`timescale 1ns/1ps

module tb_combinational_karatsuba;

parameter N = 16;

// declare your signals as reg or wire
reg [15:0]X,Y;
wire [31:0]Z;

initial begin

// write the stimuli conditions
X=16'b0001;
Y=16'b0101;

end
initial
$monitor("X=%b,Y=%b,Z=%b",X,Y,Z);

karatsuba_16 dut (.X(X), .Y(Y), .Z(Z));

initial begin
    $dumpfile("combinational_karatsuba.vcd");
    $dumpvars(0, tb_combinational_karatsuba);
    #100 $finish;
end

endmodule
