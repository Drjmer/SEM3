`timescale 1ns/1ps

module tb_cla_32bit;

parameter N = 32;     /*Change this to 16 if you want to test CLA 16-bit*/

// declare your signals as reg or wire
reg [N-1:0]a,b;
reg cin;

wire Pout,Gout;
wire [N-1:0]sum;
wire cout;

initial begin
a=32'b11111111111111111111111111111111;
b=4'b0001;
cin=1'b0;

// write the stimuli conditions
#1 a=a+1'b1;
b=b+1'b1;

end
initial
$monitor("a=%b,b=%b,cin=%b,Pout=%b,Gout=%b,S=%b,Cout=%b",a,b,cin,Pout,Gout,sum,cout);



// CLA_16bit dut (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout), .Pout(Pout), .Gout(Gout));
CLA_32bit dut (.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout),.Pout(Pout),.Gout(Gout));
initial #100 $finish;

initial begin
    $dumpfile("cla_32bit.vcd");
    $dumpvars(0, tb_cla_32bit);
end

endmodule
