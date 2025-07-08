module mod_demod(
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);

always @(posedge clk) begin
    if (rst) begin
        modulated_signal <= 'b0;
        demodulated_data <= 'b0;
    end else begin
        modulated_signal <= data_in;
        demodulated_data <= data_in;
    end
end

endmodule