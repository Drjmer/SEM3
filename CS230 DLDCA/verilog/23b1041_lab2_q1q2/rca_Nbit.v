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
assign co[0]=cin;
generate
    genvar i;
    for(i=0;i<N;i=i+1)
        begin
         full_adder fi(.a(a[i]),.b(b[i]),.cin(co[i]),.S(S[i]),.c(co[i+1]));
        end
    endgenerate
   assign c=co[N];
endmodule


