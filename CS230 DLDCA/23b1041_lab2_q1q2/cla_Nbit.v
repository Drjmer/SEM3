module CLA_4bit(a, b, cin, sum, cout);
input [3:0] a,b;
input cin;
output [3:0]sum;
output cout;

wire [4:0]c;
assign c[0]=cin;
wire [3:0]p;
wire [3:0]g;

generate 
    genvar i;
    for(i=0;i<4;i=i+1)
        begin
          assign p[i]=a[i]^b[i];
          assign g[i]=a[i]&b[i];
          assign c[i+1]=g[i]|(p[i]&c[i]);
          assign sum[i]=p[i]^c[i];
        end
endgenerate

assign co=c[4];


endmodule


module CLA_4bit_P_G(a, b, cin, sum, P, G);
input [3:0]a;
input [3:0]b;
input cin;
output [3:0]sum;
output P,G;

wire [4:0]c;
assign c[0]=cin;
output [3:0]p;
output [3:0]g;

generate 
    genvar i;
    for(i=0;i<4;i=i+1)
        begin
          assign p[i]=a[i]^b[i];
          assign g[i]=a[i]&b[i];
          assign c[i+1]=g[i]|(p[i]&c[i]);
          assign sum[i]=p[i]^c[i];
        end
endgenerate

assign co=c[4];
assign P=p[0]&p[1]&p[2]&p[3];
assign G=g[3]|p[3]&g[2]|p[3]&p[2]&g[1]|p[3]&p[2]&p[1]&g[0];


endmodule


module lookahead_carry_unit_16_bit(input P0, G0, P1, G1, P2, G2, P3, G3, cin, output  C4, C8, C12, C16, GF, PF);

    assign C4=cin&P0|G0;
    assign C8=C4&P1|G1;
    assign C12=C8&P2|G2;
    assign C16=C12&P3|G3;

    assign GF=G3|P3&G2|P3&P2&G1|P3&P2&P1&G0;

    assign PF=P0&P1&P2&P3;    

endmodule


module CLA_16bit(a, b, cin, sum, cout, Pout, Gout);
    input [15:0]a,b;
    input cin;
    output cout;
    output Pout,Gout;
    output [15:0]sum;

    wire P0, G0, P1, G1, P2, G2, P3, G3, cin, C4, C8, C12, C16, GF, PF;
    lookahead_carry_unit_16_bit U(P0, G0, P1, G1, P2, G2, P3, G3, cin, C4, C8, C12, C16, GF, PF);


    CLA_4bit_P_G c1(a[3:0],b[3:0],cin,sum[3:0],P0,G0);
    
    CLA_4bit_P_G c2(a[7:4],b[7:4],C4,sum[7:4],P1,G1);
   
    CLA_4bit_P_G c3(a[11:8],b[11:8],C8,sum[11:8],P2,G2);
    
    CLA_4bit_P_G c4(a[15:12],b[15:12],C12,sum[15:12],P3,G3);
    assign Pout=PF;
    assign Gout=GF;
    
    assign cout=C16;
endmodule


module CLA_32bit(a, b, cin, sum, cout, Pout, Gout);

input [31:0]a,b;
input cin;
output[31:0] sum;
output cout;
output Pout,Gout;
wire P0,P1,G0,G1,C16,C32,PF,GF;

lookahead_carry_unit_32_bit U1(P0,G0,P1,G1,cin,C16,C32,GF,PF);

CLA_16bit u1(a[15:0],b[15:0],cin,sum[15:0],C16,P0,G0);
CLA_16bit u2(a[31:16],b[31:16],C16,sum[31:16],C32,P1,G1);

assign cout=C32;
assign Pout=PF;
assign Gout=GF;


endmodule

module lookahead_carry_unit_32_bit (input P0, G0, P1, G1, cin, output C16, C32,  GF, PF);

assign C16=G0|P0&cin;
assign C32=G1|P1&C16;
assign GF=G1|P0&G0;
assign PF=P0&P1;


endmodule

