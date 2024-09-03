module k_test_bench();

reg x1,x2,x3,x4;
wire A,B,C,D,E,F,G;

bcd_to_7  uut(
    .x1(x1),
    .x2(x2),
    .x3(x3),
    .x4(x4),
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .F(F),
    .G(G)
);

initial 
begin 
$monitor("x1=%b x2=%b x3=%b x4=%b A=%b B=%b C=%b D=%b E=%b F=%b G=%b",x1,x2,x3,x4,A,B,C,D,E,F,G);
x1=0;x2=0;x3=0;x4=0;

#1 x4=1;
#2 x4=0; x3=1;
#3 x4=1;
#4 x3=0;
x4=0;
x2=1;
#5 x4=1;
#6 x4=0;
x3=1;
#7 x4=1;
#8 x1=1;
x2=0;
x3=0;
x4=0;
#9 x4=1;
#11 $finish;
end
initial
begin
$dumpfile("drj.vcd");
$dumpvars(0,k_test_bench);
$display("Merchant Dhruvraj 23b1041");
end
endmodule