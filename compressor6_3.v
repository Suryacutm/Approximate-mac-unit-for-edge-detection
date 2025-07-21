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