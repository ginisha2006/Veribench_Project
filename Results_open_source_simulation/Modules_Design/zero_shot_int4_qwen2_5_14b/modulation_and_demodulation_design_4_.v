module mod_demod #(
    parameter DATA_WIDTH = 16
)(
    input clk,
    input rst,
    input [DATA_WIDTH-1:0] data_in,
    output reg [DATA_WIDTH-1:0] modulated_signal,
    output reg [DATA_WIDTH-1:0] demodulated_data
);
reg [DATA_WIDTH-1:0] prev_data;
always @(posedge clk or posedge rst)
begin
    if(rst)
        modulated_signal <= 0;
    else
        modulated_signal <= ~prev_data ^ data_in;
end

always @(negedge clk or posedge rst)
begin
    if(rst)
        demodulated_data <= 0;
    else
        demodulated_data <= modulated_signal ^ prev_data;
end

always @(posedge clk)
begin
    prev_data <= data_in;
end
endmodule