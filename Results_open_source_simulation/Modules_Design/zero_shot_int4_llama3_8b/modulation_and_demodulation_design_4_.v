module mod_demod(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);

always @(posedge clk) begin
    if (rst) begin
        modulated_signal <= 0;
        demodulated_data <= 0;
    end else begin
        modulated_signal <= data_in;
        demodulated_data <= modulated_signal;
    end
end

endmodule