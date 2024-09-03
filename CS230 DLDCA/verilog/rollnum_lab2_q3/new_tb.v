
module tb_comb;

reg [15:0]X,Y;
wire [31:0]Z;
reg [31:0]Z1;

karatsuba_16 dut(.X(X),.Y(Y),.Z(Z));

initial
begin
repeat(100)
begin

    check();
    if(Z1==Z) $display("Test Case Passed!!!");
    else $display("TestCase Failed");

end

end


task check;
reg [15:0]X1,Y1;
begin
    X1=$random;
    Y1=$random;
    X=X1;
    Y=Y1;
    Z1=X*Y;
    #10 ;
end
endtask

initial
$monitor("X=%d,Y=%d,Z=%d",X,Y,Z);
endmodule