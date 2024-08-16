`timescale 1ns/1ps

module tb_rca_32_bit;

parameter N = 32;

// declare your signals as reg or wire
reg [N-1:0] a,b;
reg cin;


wire  [N-1:0] S;
wire c;

rca_Nbit #(.N(N)) dut  (.a(a), .b(b), .cin(cin), .S(S), .c(c));

initial begin	
// write the stimuli conditions


a=32'b00000000000000000000000000000000;
b=32'b00000000000000000000000000000000;
cin=1'b0;
end

always #2 b= b+4'b1011;
always #3 a=a+4'b1100;
always #10 cin=~cin;

initial 
begin

$monitor("a=%b,b=%b,cin=%b,S=%b,c=%b",a,b,cin,S,c);
end
initial
begin
#200 $finish;
end


initial begin
    $dumpfile("rca_32bit.vcd");
    $dumpvars(0, tb_rca_32_bit);
end

endmodule
