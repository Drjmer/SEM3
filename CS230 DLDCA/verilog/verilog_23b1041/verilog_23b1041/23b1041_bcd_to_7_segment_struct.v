module bcd_to_7 (x1,x2,x3,x4,A,B,C,D,E,F,G );

input x1,x2,x3,x4;
output A,B,C,D,E,F,G;

//for A
assign A= (~x1&~x2&x3)|(~x1&x2&x4)|(~x2&~x3&~x4)|(x1&~x2&~x3);

//for b
assign B= (~x1&~x2)|(~x1&~x4&~x3)|(~x2&~x3&~x4)|(x1&~x2&~x3)|(x3&x4&~x1);

//for C;

assign C= (~x1&x2)|(~x2&~x3&~x4)|(~x1&x4)|(~x2&~x3);

//for D:

assign D= (~x2&~x3&~x4)|(~x1&~x2&x3)|(~x1&~x3&x2&x4)|(~x1&~x4&x2&x3);

//for E 

assign E= (~x1&~x4&x3)|(~x2&~x3&~x4);

//for F 
assign F= (~x1&~x2&~x3&~x4)|(~x1&x2&~x3)|(x1&~x2&~x3)|(~x1&x2&x3&~x4);

//for G
assign G= (~x1&x2&~x3)| (x1&~x2&~x3) | (~x1&x3&~x2)| (~x1&x3&~x4);






endmodule