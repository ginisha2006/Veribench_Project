module mod_demod #(
    parameter DATA_WIDTH = 16
)(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);

reg [DATA_WIDTH-1:0] internal_modulated;

always @(posedge clk or posedge rst)
begin
    if(rst)
        internal_modulated <= 0;
    else
        internal_modulated <= ~data_in; // Simple example of modulation
end

assign modulated_signal = internal_modulated;

always @(negedge clk or posedge rst)
begin
    if(rst)
        demodulated_data <= 0;
    else
        demodulated_data <= ~modulated_signal; // Simple example of demodulation
end

endmodule