module tb_mod_demod (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] modulated_signal,
    output reg [15:0] demodulated_data
);

mod_demod #(.DATA_WIDTH(16)) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .modulated_signal(modulated_signal),
    .demodulated_data(demodulated_data)
);

reg clk;
always #5 clk = ~clk;

always @(*) begin assert (@(posedge clk) disable iff (!rst) ##[0:$] !($isunknown(data_in))); end

always @(*) begin assert (@(negedge rst) disable iff (!rst) demodulated_data == 16'h0000); end

always @(*) begin assert (@(posedge clk) disable iff (!rst) modulated_signal == data_in ^ 16'hFFFF); end

always @(*) begin assert (@(posedge clk) disable iff (!rst) demodulated_data == modulated_signal ^ 16'hFFFF); end

always @(*) begin assert (@(posedge clk) disable iff (!rst) demodulated_data == data_in); end

endmodule