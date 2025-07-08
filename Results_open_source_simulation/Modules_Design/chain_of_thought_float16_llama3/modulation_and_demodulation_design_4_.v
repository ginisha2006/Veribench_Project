module mod_demod(
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);

always @(posedge clk)
begin
    if (rst)
        modulated_signal <= 'b0;
    else
        modulated_signal <= data_in;
end

always @(negedge clk)
begin
    if (rst)
        demodulated_data <= 'b0;
    else
        demodulated_data <= modulated_signal;
end

endmodule