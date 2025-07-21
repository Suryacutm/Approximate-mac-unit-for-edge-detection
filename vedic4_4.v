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