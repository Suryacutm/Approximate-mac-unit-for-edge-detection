`timescale 1ns / 1ps
module accumulator (
    clk,
    reset,
    input_data,
    accumulated_result
);
    input wire clk;
    input wire reset;
    input wire [31:0] input_data;
    output reg [31:0] accumulated_result;

    always @(posedge clk or posedge reset) begin
        if (reset)
            accumulated_result <= 32'b0;  
        else
            accumulated_result <= accumulated_result + input_data;  
    end
endmodule

module compressor6_3(
    a, b, c, d, e, f,
    sum, carry, overflow
);
    input a, b, c, d, e, f;
    output sum, carry, overflow;
    wire sum1, carry1, sum2, carry2;

    assign {carry1, sum1} = a + b + c;
    assign {carry2, sum2} = d + e + f;

    assign sum = sum1 ^ sum2;
    assign carry = carry1 ^ carry2;
    assign overflow = carry1 & carry2;
endmodule

module vedic4_4 (
     A, 
     B, 
    result 
);
    input [3:0] A;
    input [3:0] B; 
    output [7:0] result;
     
    wire [3:0] p0, p1, p2;
    wire [5:0] sum1;
    wire [7:0] sum2;

    assign p0 = A[1:0] * B[1:0];
    assign p1 = A[3:2] * B[1:0];
    assign p2 = A[1:0] * B[3:2];
    
    // Simplified summation
    assign sum1 = {2'b00, p0} + {p1, 2'b00}; 
    assign sum2 = {sum1} + {p2, 2'b00}; 

    assign result = sum2;
endmodule


module vedic8_8(
    a, b,
    product
);
    input [7:0] a, b;
    output [15:0] product;    

    wire [7:0] p0, p1, p2, p3;
    wire [15:0] temp1, temp2, temp3, temp4;

    vedic4_4 vm1(a[3:0], b[3:0], p0);
    vedic4_4 vm2(a[3:0], b[7:4], p1);
    vedic4_4 vm3(a[7:4], b[3:0], p2);
    vedic4_4 vm4(a[7:4], b[7:4], p3);

    assign temp1 = {8'b0, p0};           
    assign temp2 = {4'b0, p1, 4'b0};     
    assign temp3 = {4'b0, p2, 4'b0};     
    assign temp4 = {p3, 8'b0};           

    wire sum, carry, overflow;
    compressor6_3 c1(temp1[7], temp2[7], temp3[7], temp1[8], temp2[8], temp3[8], sum, carry, overflow);

    assign product = temp1 + temp2 + temp3 + temp4 + {overflow, carry, sum};
endmodule

module reduction_unit_with_6_3 (
    A, B, C, D, E, F, G, H,
    Result
);
    input wire [15:0] A, B, C, D, E, F, G, H;
    output wire [31:0] Result;    

    wire [15:0] sum1, sum2;
    wire carry1, carry2, carry3, carry4, carry5, carry6, carry7, carry8;

    compressor6_3 comp1 (.a(A[0]), .b(B[0]), .c(C[0]), .d(D[0]), .e(E[0]), .f(F[0]), .sum(sum1[0]), .carry(sum2[0]), .overflow(carry1));
    compressor6_3 comp2 (.a(G[0]), .b(H[0]), .c(sum1[0]), .d(sum2[0]), .e(carry1), .f(1'b0), .sum(Result[0]), .carry(Result[1]), .overflow(carry2));

    compressor6_3 comp3 (.a(A[1]), .b(B[1]), .c(C[1]), .d(D[1]), .e(E[1]), .f(F[1]), .sum(sum1[1]), .carry(sum2[1]), .overflow(carry3));
    compressor6_3 comp4 (.a(G[1]), .b(H[1]), .c(sum1[1]), .d(sum2[1]), .e(carry2), .f(carry3), .sum(Result[2]), .carry(Result[3]), .overflow(carry4));

    compressor6_3 comp5 (.a(A[2]), .b(B[2]), .c(C[2]), .d(D[2]), .e(E[2]), .f(F[2]), .sum(sum1[2]), .carry(sum2[2]), .overflow(carry5));
    compressor6_3 comp6 (.a(G[2]), .b(H[2]), .c(sum1[2]), .d(sum2[2]), .e(carry4), .f(carry5), .sum(Result[4]), .carry(Result[5]), .overflow(carry6));

    compressor6_3 comp7 (.a(A[3]), .b(B[3]), .c(C[3]), .d(D[3]), .e(E[3]), .f(F[3]), .sum(sum1[3]), .carry(sum2[3]), .overflow(carry7));
    compressor6_3 comp8 (.a(G[3]), .b(H[3]), .c(sum1[3]), .d(sum2[3]), .e(carry6), .f(carry7), .sum(Result[6]), .carry(Result[7]), .overflow(carry8));

    // Continue for remaining bits as needed
endmodule

module hybrid_mac (
    activation, weight,
    clk, reset,
    mac_result
);
    input wire [7:0] activation, weight;
    input wire clk, reset;
    output wire [31:0] mac_result;

    wire [15:0] product;
    wire [31:0] reduction_result;

    vedic8_8 vedic_mult (.a(activation), .b(weight), .product(product));

    reduction_unit_with_6_3 hreduce (
        .A({16{product[15]}}),  
        .B({16{product[15]}}),
        .C({16{product[15]}}),
        .D({16{product[15]}}),
        .E({16{product[15]}}),
        .F({16{product[15]}}),
        .G({16{product[15]}}),
        .H({16{product[15]}}),
        .Result(reduction_result)
    );

    accumulator acc (
        .clk(clk),
        .reset(reset),
        .input_data(reduction_result),
        .accumulated_result(mac_result)
    );
endmodule
