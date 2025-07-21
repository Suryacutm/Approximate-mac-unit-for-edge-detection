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

module vedic4_4(
    a, b,
    product
);
    input [3:0] a, b;
    output [7:0] product; 

    wire [3:0] p0, p1, p2, p3;
    wire [7:0] temp1, temp2, temp3, temp4;

    assign p0 = a[1:0] * b[1:0];
    assign p1 = a[1:0] * b[3:2];
    assign p2 = a[3:2] * b[1:0];
    assign p3 = a[3:2] * b[3:2];

    assign temp1 = {4'b0, p0};
    assign temp2 = {2'b0, p1, 2'b0};
    assign temp3 = {2'b0, p2, 2'b0};
    assign temp4 = {4'b0, p3};

    assign product = temp1 + temp2 + temp3 + temp4;
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
