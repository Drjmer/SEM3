/* 32-bit simple karatsuba multiplier */

/*32-bit Karatsuba multipliction using a single 16-bit module*/

module iterative_karatsuba_32_16(clk, rst, enable, A, B, C);
    input clk;
    input rst;
    input [31:0] A;
    input [31:0] B;
    output [63:0] C;
    
    input enable;
    
    
    wire [1:0] sel_x;
    wire [1:0] sel_y;
    
    wire [1:0] sel_z;
    wire [1:0] sel_T;
    
    
    wire done;
    wire en_z;
    wire en_T;
    
    
    wire [32:0] h1;
    wire [32:0] h2;
    wire [63:0] g1;
    wire [63:0] g2;
    
    assign C = g2;
    reg_with_enable #(.N(63)) Z(.clk(clk), .rst(rst), .en(en_z), .X(g1), .O(g2) );  // Fill in the proper size of the register
    reg_with_enable #(.N(32)) T(.clk(clk), .rst(rst), .en(en_T), .X(h1), .O(h2) );  // Fill in the proper size of the register
    
    iterative_karatsuba_datapath dp(.clk(clk), .rst(rst), .X(A), .Y(B), .Z(g2), .T(h2), .sel_x(sel_x), .sel_y(sel_y), .sel_z(sel_z), .sel_T(sel_T), .en_z(en_z), .en_T(en_T), .done(done), .W1(g1), .W2(h1));
    iterative_karatsuba_control control(.clk(clk),.rst(rst), .enable(enable), .sel_x(sel_x), .sel_y(sel_y), .sel_z(sel_z), .sel_T(sel_T), .en_z(en_z), .en_T(en_T), .done(done));
    
endmodule

module iterative_karatsuba_datapath(clk, rst, X, Y, T, Z, sel_x, sel_y, en_z, sel_z, en_T, sel_T, done, W1, W2);
    input clk;
    input rst;
    input [31:0] X;    // input X a
    input [31:0] Y;    // Input Y b
    input [32:0] T;    // input which sums X_h*Y_h and X_l*Y_l (its also a feedback through the register) h2
    input [63:0] Z;    // input which calculates the final outcome (its also a feedback through the register) output
    output [63:0] W1;  // Signals going to the registers as input g1
    output [32:0] W2;  // signals going to the registers as input h1
    
    input [1:0] sel_x;  // control signal 
    input [1:0] sel_y;  // control signal 
    
    input en_z;         // control signal 
    input [1:0] sel_z;  // control signal 
    input en_T;         // control signal 
    input [1:0] sel_T;  // control signal 
    
    input done;         // Final done signal
    
    
    
    //-------------------------------------------------------------------------------------------------
    
    // Write your datapath here
    //--------------------------------------------------------

    wire [15:0] X_high, X_low, Y_high, Y_low, X_sum, Y_sum;
    assign Y_high = Y[31:16];
    assign Y_low = Y[15:0];
    assign X_high = X[31:16];
    assign X_low = X[15:0];

    // Temporary variables for subtraction and complements
    wire c1, c2, overflow1, overflow2;

    // Subtract lower half from higher half for both X and Y
    subtract_Nbit #(16) sub_Y(Y_high, Y_low, 1'b0, Y_sum, overflow2, c2);
    subtract_Nbit #(16) sub_X(X_high, X_low, 1'b0, X_sum, overflow1, c1);

    // 2's complement for X_sum and Y_sum if needed
    wire [15:0] X_comp, Y_comp;
    wire comp_flag_X, comp_flag_Y;
    Complement2_Nbit #(16) complement_Y(Y_sum, Y_comp, comp_flag_Y);
    Complement2_Nbit #(16) complement_X(X_sum, X_comp, comp_flag_X);

    // Choose between original and complemented values based on carry flags
    wire [15:0] final_X, final_Y;
    assign final_Y = (c2 == 1'b0) ? Y_comp : Y_sum;
    assign final_X = (c1 == 1'b0) ? X_comp : X_sum;

    // Multiplexers for selecting parts of X and Y for multiplication
    wire [15:0] mux_X, mux_Y;

    assign mux_Y = (sel_y == 2'b00) ? 0 : 
                  (sel_y == 2'b01) ? Y_low :
                  (sel_y == 2'b10) ? Y_high : final_Y;

    assign mux_X = (sel_x == 2'b00) ? 0 : 
                  (sel_x == 2'b01) ? X_low :
                  (sel_x == 2'b10) ? X_high : final_X;
    // Perform 16-bit multiplication
    wire [31:0] partial_product;
    wire [32:0] extended_product;
    mult_16 mult16(mux_X, mux_Y, partial_product);
    
    assign extended_product = {1'b0, partial_product};

    // Adding/subtracting intermediate products
    wire [32:0] sum_result, diff_result;
    wire faltu1, faltu2, faltu3;

    adder_Nbit #(33) adder(extended_product,T, 1'b0, sum_result, faltu1);
    subtract_Nbit #(33) subtractor(T, extended_product, 1'b0, diff_result, faltu2, faltu3);

    // Choose between addition and subtraction results based on carry flags
    wire [32:0] final_sum_T;
    assign final_sum_T = ({c1, c2} == 2'b00) ? diff_result : 
                         ({c1, c2} == 2'b01) ? sum_result :
                         ({c1, c2} == 2'b10) ? diff_result : sum_result;

    // Output to the temporary register W2
    assign W2 = (sel_T == 2'b00) ? 0 : 
                (sel_T == 2'b01) ? sum_result : 
                (sel_T == 2'b10) ? sum_result : final_sum_T;

    // Calculate final 64-bit product
    wire [63:0] high_product, mid_product, low_product;
    
    assign low_product = extended_product;            // X_low * Y_low
    assign mid_product = {15'b0, W2, 16'b0};          // Intermediate result << 16
    assign high_product = {extended_product, 31'b0};   // X_high * Y_high << 32
    
    // ACCUMULATE the results
    wire [63:0] final_result1, final_result2, final_result3;
    wire ov_flag1, ov_flag2, ov_flag3;

    adder_Nbit #(64) add_low(Z, low_product, 1'b0, final_result1, ov_flag1);
    adder_Nbit #(64) add_high(Z, high_product, 1'b0, final_result2, ov_flag2);
    adder_Nbit #(64) add_mid(Z, mid_product, 1'b0, final_result3, ov_flag3);

    // Select the final output for the accumulator
    assign W1 = (sel_z == 2'b00) ? 0 : 
                (sel_z == 2'b01) ? final_result1 :
                (sel_z == 2'b10) ? final_result2 : final_result3;
    
endmodule


module iterative_karatsuba_control(clk,rst, enable, sel_x, sel_y, sel_z, sel_T, en_z, en_T, done);
    input clk;
    input rst;
    input enable;
    
    output reg [1:0] sel_x;
    output reg [1:0] sel_y;
    
    output reg [1:0] sel_z;
    output reg [1:0] sel_T;    
    
    output reg en_z;
    output reg en_T;

    output reg done;
    
   reg [5:0] current_state, next_state;
    parameter S0 = 6'b000001;  
    parameter S1 = 6'b000010;
    parameter S2 = 6'b000100;
    parameter S3 = 6'b001000;
    parameter S4 = 6'b010000;
    parameter S5 = 6'b100000;

    // State transition logic
    always @(posedge clk) begin
        if (rst) begin
            current_state <= S0;
        end
        else if (enable) begin
            current_state <= next_state;
        end
    end

    // Output logic based on the current state
    always @(*) begin
        case (current_state)
            S0: begin
                next_state <= S1; // Transition to INIT state
                sel_x <= 2'b00; 
                sel_y <= 2'b00; 
                en_z <= 1'b0; 
                sel_z <= 2'b00; 
                sel_T <= 2'b00; 
                en_T <= 1'b0; 
                done <= 1'b0; 
            end
            
            S1: begin
                next_state <= S2;
                sel_x <= 2'b01; 
                sel_y <= 2'b01; 
                en_z <= 1'b1; 
                sel_z <= 2'b01; 
                sel_T <= 2'b01; 
                en_T <= 1'b1; 
                done <= 1'b0; 
            end
            
            S2: begin
                next_state <= S3;
                sel_x <= 2'b10; 
                sel_y <= 2'b10; 
                en_z <= 1'b1; 
                sel_z <= 2'b10; 
                sel_T <= 2'b10; 
                en_T <= 1'b1; 
                done <= 1'b0; 
            end
            
            S3: begin
                next_state <= S4;
                sel_x <= 2'b11; 
                sel_y <= 2'b11; 
                en_z <= 1'b1; 
                sel_z <= 2'b11; 
                sel_T <= 2'b11; 
                en_T <= 1'b0; 
                done <= 1'b0; 
            end 
            
            S4: begin
                next_state <= S5;
                sel_x <= 2'b00; 
                sel_y <= 2'b00; 
                en_z <= 1'b0; 
                sel_z <= 2'b00; 
                sel_T <= 2'b00; 
                en_T <= 1'b1; 
                done <= 1'b1; 
            end 
            
            S5: begin
                next_state <= S0; // Loop back to IDLE
                sel_x <= 2'b00; 
                sel_y <= 2'b00; 
                en_z <= 1'b1; 
                sel_z <= 2'b00; 
                sel_T <= 2'b00; 
                en_T <= 1'b1; 
                done <= 1'b0; 
            end
            
            default: begin
                next_state <= S0; // Reset to IDLE on error
                sel_x <= 2'b00; 
                sel_y <= 2'b00; 
                en_z <= 1'b0; 
                sel_z <= 2'b00; 
                sel_T <= 2'b00; 
                en_T <= 1'b0; 
                done <= 1'b0; 
            end  
        endcase
    end 
endmodule


module reg_with_enable #(parameter N = 32) (clk, rst, en, X, O );
    input [N:0] X;
    input clk;
    input rst;
    input en;
    output [N:0] O;
    
    reg [N:0] R;
    
    always@(posedge clk) begin
        if (rst) begin
            R <= {N{1'b0}};
        end
        if (en) begin
            R <= X;
        end
    end
    assign O = R;
endmodule


/*-------------------Supporting Modules--------------------*/
/*------------- Iterative Karatsuba: 32-bit Karatsuba using a single 16-bit Module*/

module mult_16(X, Y, Z);
input [15:0] X;
input [15:0] Y;
output [31:0] Z;

assign Z = X*Y;

endmodule


module mult_17(X, Y, Z);
input [16:0] X;
input [16:0] Y;
output [33:0] Z;

assign Z = X*Y;

endmodule

module full_adder(a, b, cin, S, cout);
input a;
input b;
input cin;
output S;
output cout;

assign S = a ^ b ^ cin;
assign cout = (a&b) ^ (b&cin) ^ (a&cin);

endmodule


module check_subtract (A, B, C);
input [7:0] A;
input [7:0] B;
output [8:0] C;

assign C = A - B; 
endmodule



/* N-bit RCA adder (Unsigned) */
module adder_Nbit #(parameter N = 32) (a, b, cin, S, cout);
input [N-1:0] a;
input [N-1:0] b;
input cin;
output [N-1:0] S;
output cout;

wire [N:0] cr;  

assign cr[0] = cin;


generate
    genvar i;
    for (i = 0; i < N; i = i + 1) begin
        full_adder addi (.a(a[i]), .b(b[i]), .cin(cr[i]), .S(S[i]), .cout(cr[i+1]));
    end
endgenerate    


assign cout = cr[N];

endmodule


module Not_Nbit #(parameter N = 32) (a,c);
input [N-1:0] a;
output [N-1:0] c;

generate
genvar i;
for (i = 0; i < N; i = i+1) begin
    assign c[i] = ~a[i];
end
endgenerate 

endmodule


/* 2's Complement (N-bit) */
module Complement2_Nbit #(parameter N = 32) (a, c, cout_comp);

input [N-1:0] a;
output [N-1:0] c;
output cout_comp;

wire [N-1:0] b;
wire ccomp;

Not_Nbit #(.N(N)) compl(.a(a),.c(b));
adder_Nbit #(.N(N)) addc(.a(b), .b({ {N-1{1'b0}} ,1'b1 }), .cin(1'b0), .S(c), .cout(ccomp));

assign cout_comp = ccomp;

endmodule


/* N-bit Subtract (Unsigned) */
module subtract_Nbit #(parameter N = 32) (a, b, cin, S, ov, cout_sub);

input [N-1:0] a;
input [N-1:0] b;
input cin;
output [N-1:0] S;
output ov;
output cout_sub;

wire [N-1:0] minusb;
wire cout;
wire ccomp;

Complement2_Nbit #(.N(N)) compl(.a(b),.c(minusb), .cout_comp(ccomp));
adder_Nbit #(.N(N)) addc(.a(a), .b(minusb), .cin(1'b0), .S(S), .cout(cout));

assign ov = (~(a[N-1] ^ minusb[N-1])) & (a[N-1] ^ S[N-1]);
assign cout_sub = cout | ccomp;

endmodule



/* n-bit Left-shift */

module Left_barrel_Nbit #(parameter N = 32)(a, n, c);

input [N-1:0] a;
input [$clog2(N)-1:0] n;
output [N-1:0] c;


generate
genvar i;
for (i = 0; i < $clog2(N); i = i + 1 ) begin: stage
    localparam integer t = 2**i;
    wire [N-1:0] si;
    if (i == 0) 
    begin 
        assign si = n[i]? {a[N-t:0], {t{1'b0}}} : a;
    end    
    else begin 
        assign si = n[i]? {stage[i-1].si[N-t:0], {t{1'b0}}} : stage[i-1].si;
    end
end
endgenerate

assign c = stage[$clog2(N)-1].si;

endmodule