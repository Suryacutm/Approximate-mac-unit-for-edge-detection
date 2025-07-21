module hybrid_mac (
     activation, weight,
	 clk,reset,
     mac_result
);
input wire [7:0] activation, weight;
	 input wire clk,reset;
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
