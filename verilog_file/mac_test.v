`timescale 1ns / 1ps

module mac_test;

    // Inputs
    reg [7:0] activation;       // 8-bit activation input
    reg [7:0] weight;           // 8-bit weight input
    reg clk;                    // Clock signal
    reg reset;                  // Reset signal

    // Outputs
    wire [31:0] mac_result;     // MAC accumulated result

    // Internal Signals (for debugging, make these ports in the DUT if needed)
    wire [15:0] product;        // Product from the multiplier
    wire [31:0] reduction_result; // Reduction unit output

    // Instantiate the DUT (Device Under Test)
    hybrid_mac uut (
        .activation(activation),
        .weight(weight),
        .clk(clk),
        .reset(reset),
        .mac_result(mac_result)
    );

    // Assign internal signals for debugging (if these are ports in the DUT)
    assign product = uut.vedic_mult.product;  // Access multiplier product
    assign reduction_result = uut.hreduce.Result; // Access reduction unit output

    // Clock Generation: 100 MHz clock (10 ns period)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;              // Start with reset active
        activation = 0;
        weight = 0;

        // Apply reset for 2 clock cycles
        #10;
        reset = 0;              // Deactivate reset

        // Apply Stimulus
        @(posedge clk);
        activation = 8'd10;     // Apply activation = 10
        weight = 8'd5;          // Apply weight = 5

        @(posedge clk);
        activation = 8'd255;    // Apply activation = 255 (-1 in 8-bit signed)
        weight = 8'd2;          // Apply weight = 2

        @(posedge clk);
        activation = 8'd4;      // Apply activation = 4
        weight = 8'd3;          // Apply weight = 3

        @(posedge clk);
        activation = 8'd127;    // Apply activation = 127 (max positive)
        weight = 8'd127;        // Apply weight = 127 (max positive)

        @(posedge clk);
        activation = 8'd128;    // Apply activation = 128 (-128 in signed)
        weight = 8'd128;        // Apply weight = 128 (-128 in signed)

        @(posedge clk);
        activation = 8'd0;      // Apply activation = 0
        weight = 8'd0;          // Apply weight = 0

        // Test Reset Again
        @(posedge clk);
        reset = 1;              // Assert reset
        @(posedge clk);
        reset = 0;              // Deassert reset

        // End simulation after sufficient time
        #100;
        $finish;
    end

    // Debugging and Monitoring
    initial begin
        $monitor("Time=%0t | Activation=%0d | Weight=%0d | Product=%0d | Reduction_Result=%0d | MAC_Result=%0d", 
                 $time, activation, weight, product, reduction_result, mac_result);
    end

endmodule