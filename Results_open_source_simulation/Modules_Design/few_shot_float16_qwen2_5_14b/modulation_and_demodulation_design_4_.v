module mod_demod #(
    parameter DATA_WIDTH = 16
)(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);

reg [DATA_WIDTH-1:0] internal_signal;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        modulated_signal <= {DATA_WIDTH{1'b0}};
        demodulated_data <= {DATA_WIDTH{1'b0}};
    end
    else
    begin
        // Modulation process
        internal_signal = data_in ^ {DATA_WIDTH{1'b1}}; // Example modulation
        modulated_signal <= internal_signal;

        // Demodulation process
        demodulated_data <= internal_signal ^ {DATA_WIDTH{1'b1}}; // Example demodulation
    end
end

endmodule