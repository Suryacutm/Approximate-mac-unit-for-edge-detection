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
