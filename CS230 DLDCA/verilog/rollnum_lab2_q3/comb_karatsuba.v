module karatsuba_16(X,Y,Z);
input [15:0]X,Y;
output [31:0]Z;

wire [7:0]X1,X2,Y1,Y2;

assign X1=X[15:8];
assign X2=X[7:0];

assign Y1=Y[15:8];
assign Y2=Y[7:0];

wire [15:0]Z1,Z3;
karatsuba_8 k1(X1,Y1,Z1);
karatsuba_8 k3(X2,Y2,Z3);

wire cout1,cout2;
wire [7:0]sum1,sum2;
rca_Nbit #(.N(8)) a4(.a(X1),.b(X2),.cin(1'b0),.S(sum1),.c(cout1));
rca_Nbit #(.N(8)) a5(.a(Y1),.b(Y2),.cin(1'b0),.S(sum2),.c(cout2));


wire [31:0]r1;
wire [31:0] r2,r3;

wire [7:0]n1,n2;
generate
    genvar i;
    for(i=0;i<8;i=i+1)
        begin
         assign n1[i]=sum1[i]&cout2;
         assign n2[i]=sum2[i]&cout1;
        end
endgenerate

assign r1={15'b0,cout1&cout2,16'b0};
assign r2={16'b0,n1,8'b0};
assign r3={16'b0,n2,8'b0};

wire [15:0]Z2;
karatsuba_8 k2(sum1,sum2,Z2);

wire [31:0] r4;
assign r4={31'b0,Z2};
wire [31:0]s1,s2,s3;
wire cout3,cout4,cout5;

wire [31:0]F1t,F3t;

assign F1t={31'b0,Z1};
assign F3t={31'b0,Z3};

wire [31:0]F2t;
rca_Nbit #(.N(32)) a1(.a(r1),.b(r2),.cin(1'b0),.S(s1),.c(cout3));
rca_Nbit #(.N(32)) a2(.a(s1),.b(r3),.cin(1'b0),.S(s2),.c(cout4));
rca_Nbit #(.N(32)) a3(.a(s2),.b(r4),.cin(1'b0),.S(F2t),.c(cout5));


wire [31:0]diff1,F2tt;
wire bin1,bin2;
rca_Nbit #(.N(32)) su1(.a(F2t),.b(F1t),.cin(1'b1),.S(diff1),.c(bin1));
rca_Nbit #(.N(32)) su2(.a(diff1),.b(F3t),.cin(1'b1),.S(F2tt),.c(bin2));

wire [31:0]F1,F2,F3;
assign F1=Z1<<16;
assign F2=F2tt<<8;
assign F3=Z3;

wire [31:0] sumt1,sumt2;
wire cout6,cout7;
rca_Nbit #(.N(32))  f1(.a(F1),.b(F2),.cin(1'b0),.S(sumt1),.c(cout6));
rca_Nbit #(.N(32))   f2(.a(sumt1),.b(F3),.cin(1'b0),.S(Z),.c(cout7));
endmodule










module karatsuba_8(X,Y,Z);
input [7:0]X,Y;
output [15:0]Z;

wire [3:0]X1,X2,Y1,Y2;

assign X1=X[7:4];
assign X2=X[3:0];

assign Y1=Y[7:4];
assign Y2=Y[3:0];

wire [7:0]Z1,Z3;
karatsuba_4 k1(X1,Y1,Z1);
karatsuba_4 k3(X2,Y2,Z3);

wire cout1,cout2;
wire [3:0]sum1,sum2;
rca_Nbit #(.N(4)) a4(.a(X1),.b(X2),.cin(1'b0),.S(sum1),.c(cout1));
rca_Nbit #(.N(4)) a5(.a(Y1),.b(Y2),.cin(1'b0),.S(sum2),.c(cout2));


wire [15:0]r1;
wire [15:0] r2,r3;

wire [3:0]n1,n2;
generate
    genvar i;
    for(i=0;i<4;i=i+1)
        begin
         assign n1[i]=sum1[i]&cout2;
         assign n2[i]=sum2[i]&cout1;
        end
endgenerate

assign r1={7'b0,cout1&cout2,8'b0};
assign r2={8'b0,n1,4'b0};
assign r3={8'b0,n2,4'b0};

wire [7:0]Z2;
karatsuba_4 k2(sum1,sum2,Z2);

wire [15:0] r4;
assign r4={15'b0,Z2};
wire [15:0]s1,s2,s3;
wire cout3,cout4,cout5;

wire [15:0]F1t,F3t;

assign F1t={15'b0,Z1};
assign F3t={15'b0,Z3};

wire [15:0]F2t;
rca_Nbit #(.N(16)) a1(.a(r1),.b(r2),.cin(1'b0),.S(s1),.c(cout3));
rca_Nbit #(.N(16)) a2(.a(s1),.b(r3),.cin(1'b0),.S(s2),.c(cout4));
rca_Nbit #(.N(16)) a3(.a(s2),.b(r4),.cin(1'b0),.S(F2t),.c(cout5));


wire [15:0]diff1,F2tt;
wire bin1,bin2;
rca_Nbit #(.N(16)) su1(.a(F2t),.b(F1t),.cin(1'b1),.S(diff1),.c(bin1));
rca_Nbit #(.N(16)) su2(.a(diff1),.b(F3t),.cin(1'b1),.S(F2tt),.c(bin2));

wire [15:0]F1,F2,F3;
assign F1=Z1<<8;
assign F2=F2tt<<4;
assign F3=Z3;

wire [15:0] sumt1,sumt2;
wire cout6,cout7;
rca_Nbit #(.N(16))  f1(.a(F1),.b(F2),.cin(1'b0),.S(sumt1),.c(cout6));
rca_Nbit #(.N(16))   f2(.a(sumt1),.b(F3),.cin(1'b0),.S(Z),.c(cout7));
endmodule












module karatsuba_4(X,Y,Z);
input [3:0]X,Y;
output [7:0]Z;

wire [1:0]X1,X2,Y1,Y2;

assign X1=X[3:2];
assign X2=X[1:0];

assign Y1=Y[3:2];
assign Y2=Y[1:0];

wire [3:0]Z1,Z3;
karatsuba_2 k1(X1,Y1,Z1);
karatsuba_2 k3(X2,Y2,Z3);

wire cout1,cout2;
wire [1:0]sum1,sum2;
rca_Nbit #(.N(2)) a4(.a(X1),.b(X2),.cin(1'b0),.S(sum1),.c(cout1));
rca_Nbit #(.N(2)) a5(.a(Y1),.b(Y2),.cin(1'b0),.S(sum2),.c(cout2));


wire [7:0]r1;
wire [7:0] r2,r3;

wire [1:0]n1,n2;
generate
    genvar i;
    for(i=0;i<2;i=i+1)
        begin
         assign n1[i]=sum1[i]&cout2;
         assign n2[i]=sum2[i]&cout1;
        end
endgenerate

assign r1={3'b0,cout1&cout2,4'b0};
assign r2={4'b0,n1,2'b0};
assign r3={4'b0,n2,2'b0};

wire [3:0]Z2;
karatsuba_2 k2(sum1,sum2,Z2);

wire [7:0] r4;
assign r4={7'b0,Z2};
wire [7:0]s1,s2,s3;
wire cout3,cout4,cout5;

wire [7:0]F1t,F3t;

assign F1t={7'b0,Z1};
assign F3t={7'b0,Z3};

wire [7:0]F2t;
rca_Nbit #(.N(8)) a1(.a(r1),.b(r2),.cin(1'b0),.S(s1),.c(cout3));
rca_Nbit #(.N(8)) a2(.a(s1),.b(r3),.cin(1'b0),.S(s2),.c(cout4));
rca_Nbit #(.N(8)) a3(.a(s2),.b(r4),.cin(1'b0),.S(F2t),.c(cout5));


wire [7:0]diff1,F2tt;
wire bin1,bin2;
rca_Nbit #(.N(8)) su1(.a(F2t),.b(F1t),.cin(1'b1),.S(diff1),.c(bin1));
rca_Nbit #(.N(8)) su2(.a(diff1),.b(F3t),.cin(1'b1),.S(F2tt),.c(bin2));

wire [7:0]F1,F2,F3;
assign F1=Z1<<4;
assign F2=F2tt<<2;
assign F3=Z3;

wire [7:0] sumt1,sumt2;
wire cout6,cout7;
rca_Nbit #(.N(8))  f1(.a(F1),.b(F2),.cin(1'b0),.S(sumt1),.c(cout6));
rca_Nbit #(.N(8))   f2(.a(sumt1),.b(F3),.cin(1'b0),.S(Z),.c(cout7));
endmodule





















module karatsuba_2(X,Y,Z);
input [1:0]X,Y;
output [3:0]Z;

wire X1,X2,Y1,Y2;

assign X1=X[1];
assign X2=X[0];

assign Y1=Y[1];
assign Y2=Y[0];

wire Z1,Z3;
karatsuba_1 k1(X1,Y1,Z1);
karatsuba_1 k3(X2,Y2,Z3);

wire cout1,cout2;
wire sum1,sum2;
rca_Nbit #(.N(1)) a4(.a(X1),.b(X2),.cin(1'b0),.S(sum1),.c(cout1));
rca_Nbit #(.N(1)) a5(.a(Y1),.b(Y2),.cin(1'b0),.S(sum2),.c(cout2));


wire [3:0]r1;
wire [3:0] r2,r3;
assign r1={1'b0,cout1&cout2,2'b0};
assign r2={2'b0,sum1&cout2,1'b0};
assign r3={2'b0,sum2&cout1,1'b0};

wire Z2;
karatsuba_1 k2(sum1,sum2,Z2);

wire [3:0] r4;
assign r4={3'b0,Z2};
wire [3:0]s1,s2,s3;
wire cout3,cout4,cout5;

wire [3:0]F1t,F3t;

assign F1t={3'b0,Z1};
assign F3t={3'b0,Z3};

wire [3:0]F2t;
rca_Nbit #(.N(4)) a1(.a(r1),.b(r2),.cin(1'b0),.S(s1),.c(cout3));
rca_Nbit #(.N(4)) a2(.a(s1),.b(r3),.cin(1'b0),.S(s2),.c(cout4));
rca_Nbit #(.N(4)) a3(.a(s2),.b(r4),.cin(1'b0),.S(F2t),.c(cout5));


wire [3:0]diff1,F2tt;
wire bin1,bin2;
rca_Nbit #(.N(4)) su1(.a(F2t),.b(F1t),.cin(1'b1),.S(diff1),.c(bin1));
rca_Nbit #(.N(4)) su2(.a(diff1),.b(F3t),.cin(1'b1),.S(F2tt),.c(bin2));

wire [3:0]F1,F2,F3;
assign F1=Z1<<2;
assign F2=F2tt<<1;
assign F3=Z3;

wire [3:0] sumt1,sumt2;
wire cout6,cout7;
rca_Nbit #(.N(4))  f1(.a(F1),.b(F2),.cin(1'b0),.S(sumt1),.c(cout6));
rca_Nbit #(.N(4))   f2(.a(sumt1),.b(F3),.cin(1'b0),.S(Z),.c(cout7));
endmodule

module karatsuba_1(X,Y,Z);

input X,Y;
output Z;

assign Z=X&Y;

endmodule
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
wire [N-1:0] b1;
wire [N:0] co;
wire [N-1:0] s1;
assign co[0]=cin;
generate
    genvar i;
    for(i=0;i<N;i=i+1)
        begin
         xor x1(b1[i],b[i],cin);
         full_adder fi(.a(a[i]),.b(b1[i]),.cin(co[i]),.S(s1[i]),.c(co[i+1]));
        end
endgenerate
   assign c=co[N];
   assign S = cin==0?(s1):(c==0?(32'b0):(s1));
endmodule


