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