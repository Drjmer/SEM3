module karatsuba_16 (X, Y, Z);
input [15:0] X,Y;
output [31:0]Z;


wire [8:0]Xr,Xl,Yr,Yl;
wire [8:0]Xm,Ym;
wire [16:0]Xms;
assign Xr[8]=0;
assign Xr = X[15:8];
assign Xl[8]= 0;
assign Xl=X[7:0];
assign Yr[8]=0;
assign Yr=Y[15:8];
assign Yl[8]=0;
assign Yl=Y[7:0];
wire cout1,cout2,cout3;
wire [16:0]Z1,Z2,Z3;
rca_Nbit #(.N(9)) add1(Xr,Xl,1'b0,Xm,cout1);
rca_Nbit #(.N(9)) add2(Yr,Yl,1'b0,Ym,cout2);



karatsuba_8  k1(Xr,Yr,Z1);
karatsuba_8  k2(Xl,Yl,Z2);
karatsuba_8  k3(Xm,Ym,Z3);


rca_Nbit #(.N(17)) add3(Z1,Z2,1'b0,Xms,cout3);

wire [16:0]sub_ans;
wire bin;
rca_Nbit #(.N(17)) sub1(Z3,Xms,1'b1,sub_ans,bin);//banana hai

wire [32:0]F1,F2;
wire [32:0]F3;
left_shift #(.N(17),.output_bit(33),.shift(16)) l1(Z1,F1);
left_shift #(.N(17),.output_bit(33),.shift(8)) l2(sub_ans,F2);

wire [32:0] ZF,ZF2;

wire cout4,cout5;
rca_Nbit #(.N(33)) add4(F1,F2,1'b0,ZF,cout4);
rca_Nbit #(.N(33)) add5(ZF,F3,1'b0,ZF2,cout5);

assign Z=ZF2[31:0];

endmodule

module karatsuba_8 (X, Y, Z);
input [8:0] X,Y;
output [16:0]Z;


wire [4:0]Xr,Xl,Yr,Yl;
wire [4:0]Xm1,Ym1;
wire [8:0]Xms;
assign Xr[4]=0;
assign Xr = X[7:4];
assign Xl[4]=0;
assign Xl=X[3:0];
assign Yr[4]=0;
assign Yr=Y[7:4];
assign Yl[4]=0;
assign Yl=Y[3:0];
wire cout1,cout2,cout3;
wire [8:0]Z1,Z2,Z3;
rca_Nbit #(.N(5)) add1(Xr,Xl,1'b0,Xm1,cout1);
rca_Nbit #(.N(5)) add2(Yr,Yl,1'b0,Ym1,cout2);



karatsuba_4  k1(Xr,Yr,Z1);
karatsuba_4  k2(Xl,Yl,Z2);
karatsuba_4  k3(Xm1,Ym1,Z3);


rca_Nbit #(.N(9)) add3(Z1,Z2,1'b0,Xms,cout3);


wire [8:0]sub_ans;
wire bin;
rca_Nbit #(.N(9)) sub1(Z3,Xms,1'b1,sub_ans,bin);//banana hai

wire [16:0]F1,F2,F3;
left_shift #(.N(9),.output_bit(17),.shift(8)) l1(Z1,F1);
left_shift #(.N(9),.output_bit(17),.shift(4)) l2(sub_ans,F2);

wire [16:0] ZF;

wire cout4,cout5;
rca_Nbit #(.N(17)) add4(F1,F2,1'b0,ZF,cout4);
rca_Nbit #(.N(17)) add5(ZF,F3,1'b0,Z,cout5);


endmodule



module karatsuba_4 (X, Y, Z);
input [4:0] X,Y;
output [8:0]Z;


wire [2:0]Xr,Xl,Yr,Yl;
wire [2:0]Xm1,Ym1;
wire [4:0]Xms;
assign Xr[2]=0;
assign Xr = X[3:2];
assign Xl[2]=0;
assign Xl=X[1:0];
assign Yr[2]=0;
assign Yr=Y[3:2];
assign Yl[2]=0;
assign Yl=Y[1:0];
wire cout1,cout2,cout3;
wire [4:0]Z1,Z2,Z3;
rca_Nbit #(.N(3)) add1(Xr,Xl,1'b0,Xm1,cout1);
rca_Nbit #(.N(3)) add2(Yr,Yl,1'b0,Ym1,cout2);



karatsuba_2  k1(Xr,Yr,Z1);
karatsuba_2  k2(Xl,Yl,Z2);
karatsuba_2  k3(Xm1,Ym1,Z3);


rca_Nbit #(.N(5)) add3(Z1,Z2,1'b0,Xms,cout3);


wire [4:0] sub_ans;
wire bin;
rca_Nbit #(.N(5)) sub1(Z3,Xms,1'b1,sub_ans,bin);//banana hai

wire [8:0]F1,F2,F3;
left_shift #(.N(5),.output_bit(9),.shift(4)) l1(Z1,F1);
left_shift #(.N(5),.output_bit(9),.shift(2)) l2(sub_ans,F2);

wire [8:0] ZF;

wire cout4,cout5;
rca_Nbit #(.N(9)) add4(F1,F2,1'b0,ZF,cout4);
rca_Nbit #(.N(9)) add5(ZF,F3,1'b0,Z,cout5);


endmodule


module karatsuba_2 (X, Y, Z);
input [2:0] X,Y;
output [4:0]Z;


wire Xr,Xl,Yr,Yl;
wire Xm1,Ym1;
wire [2:0]Xms;

assign Xr = X[1];
assign Xl=X[0];
assign Yr=Y[1];
assign Yl=Y[0];
wire cout1,cout2,cout3;
wire [2:0]Z1,Z2,Z3;
rca_Nbit #(.N(1)) add1(Xr,Xl,1'b0,Xm1,cout1);
rca_Nbit #(.N(1)) add2(Yr,Yl,1'b0,Ym1,cout2);



karatsuba_1  k1(Xr,Yr,Z1);
karatsuba_1  k2(Xl,Yl,Z2);
karatsuba_1  k3(Xm,Ym,Z3);


rca_Nbit #(.N(3)) add3(Z1,Z2,1'b0,Xms,cout3);


wire [2:0]sub_ans;
wire bin;
rca_Nbit #(.N(3)) sub1(Z3,Xms,1'b1,sub_ans,bin);//banana hai

wire [4:0]F1,F2,F3;
left_shift #(.N(3),.output_bit(5),.shift(2)) l1(Z1,F1);
left_shift #(.N(3),.output_bit(5),.shift(1)) l2(sub_ans,F2);

wire [4:0] ZF;

wire cout4,cout5;
rca_Nbit #(.N(5)) add4(F1,F2,1'b0,ZF,cout4);
rca_Nbit #(.N(5)) add5(ZF,F3,1'b0,Z,cout5);


endmodule

module karatsuba_1 (X, Y, Z);
input  X,Y;
output [2:0]Z;
assign Z[2]=0;
assign Z[1]=0;
and (Z[0],X,Y);

endmodule


//module for right shift
module left_shift #(parameter N=8,parameter output_bit=16,parameter shift=8)(a,a_out);
input [N-1:0] a;
output [output_bit-1:0] a_out;
assign a_out=a<<shift;
endmodule

//code for adding 
module half_adder(a, b, S, c);
input a,b;
output S;
output c;

assign S=a^b;
assign c=a&b;
endmodule


module full_adder(a, b, cin, S, c);
input a,b,cin;
output S,c;



wire carry_1,carry_2;
wire sum_1;

half_adder ha1(.a(a),.b(b),.S(sum_1),.c(carry_1));
half_adder ha2(.a(sum_1),.b(cin),.S(S),.c(carry_2));

assign c=carry_1|carry_2;





endmodule

module rca_Nbit #(parameter N = 32) (a, b, cin, S, c);
input [N-1:0]a,b;
input cin;
output [N-1:0] S;
output c;
wire [N:0] co;
wire [N-1:0]b1;
assign co[0]=cin;
generate
    genvar i;
    for(i=0;i<N;i=i+1)
        begin
        assign b1[i]=cin^b[i];
        full_adder fi(.a(a[i]),.b(b1[i]),.cin(co[i]),.S(S[i]),.c(co[i+1]));
        
        end
    endgenerate
   assign c=co[N];
endmodule


//subtractor

