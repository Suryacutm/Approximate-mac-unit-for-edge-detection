module reduction_unit_with_6_3 (
     A, B, C, D, E, F, G, H,
    Result
);
 input wire [15:0] A, B, C, D, E, F, G, H;
    output wire [31:0] Result;    


wire [15:0] sum1, sum2;
    wire carry1, carry2, carry3, carry4, carry5, carry6, carry7, carry8;

    // Stage 1: Use 6:3 compressors on the lower bits
    compressor6_3 comp1 (.a(A[0]), .b(B[0]), .c(C[0]), .d(D[0]), .e(E[0]), .f(F[0]), .sum(sum1[0]), .carry(sum2[0]), .overflow(carry1));
    compressor6_3 comp2 (.a(G[0]), .b(H[0]), .c(sum1[0]), .d(sum2[0]), .e(carry1), .f(1'b0), .sum(Result[0]), .carry(Result[1]), .overflow(carry2));

    // Stage 2: Reduction on the next set of bits
    compressor6_3 comp3 (.a(A[1]), .b(B[1]), .c(C[1]), .d(D[1]), .e(E[1]), .f(F[1]), .sum(sum1[1]), .carry(sum2[1]), .overflow(carry3));
    compressor6_3 comp4 (.a(G[1]), .b(H[1]), .c(sum1[1]), .d(sum2[1]), .e(carry2), .f(carry3), .sum(Result[2]), .carry(Result[3]), .overflow(carry4));

    // Stage 3: Continue reduction on the next set of bits
    compressor6_3 comp5 (.a(A[2]), .b(B[2]), .c(C[2]), .d(D[2]), .e(E[2]), .f(F[2]), .sum(sum1[2]), .carry(sum2[2]), .overflow(carry5));
    compressor6_3 comp6 (.a(G[2]), .b(H[2]), .c(sum1[2]), .d(sum2[2]), .e(carry4), .f(carry5), .sum(Result[4]), .carry(Result[5]), .overflow(carry6));

    // Stage 4: Reduction on higher bits
    compressor6_3 comp7 (.a(A[3]), .b(B[3]), .c(C[3]), .d(D[3]), .e(E[3]), .f(F[3]), .sum(sum1[3]), .carry(sum2[3]), .overflow(carry7));
    compressor6_3 comp8 (.a(G[3]), .b(H[3]), .c(sum1[3]), .d(sum2[3]), .e(carry6), .f(carry7), .sum(Result[6]), .carry(Result[7]), .overflow(carry8));

    // Continue similarly for each set of bits up to the MSB
    // Repeat this pattern, creating additional stages for bits up to A[15], B[15], etc.
    // Assign remaining sums and carries to `Result[8]` through `Result[31]`.

endmodule
