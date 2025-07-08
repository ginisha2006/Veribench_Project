module tb_digital_filter (
    input clk,
    input rst,
    input [15:0] data_in,
    output reg [15:0] data_out,
    input [15:0] coeff [31:0]
);

reg clk;
wire [15:0] data_out;

digital_filter #(.DATA_WIDTH(16), .COEFF_WIDTH(16), .NUM_TAPS(32)) dut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
);

always #5 clk = ~clk;

always @(*) begin assert (@(posedge clk) disable iff (!rst) data_out == 16'b0); end

always @(*) begin assert (@(posedge clk) disable iff (!rst) data_out[*] |-> data_out[*]); end

always @(*) begin assert (@(posedge clk) data_out >= 0); end

always @(*) begin assert (@(posedge clk) data_out <= 16'd65535); end

always @(*) begin assert (foreach(coeff[i]) coeff[i][15:0] inside {[0 : 65535]}); end

always @(*) begin assert (data_in[15:0] inside {[0 : 65535]}); end

endmodule