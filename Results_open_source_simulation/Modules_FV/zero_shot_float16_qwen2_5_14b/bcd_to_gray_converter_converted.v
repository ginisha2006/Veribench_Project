module tb_bcd_to_gray (
    input clk,
    input [3:0] bcd,
    output reg [3:0] gray
);

wire [3:0] dut_gray;

bcd_to_gray #(.BCD_WIDTH(4), .GRAY_WIDTH(4)) dut (
    .bcd(bcd),
    .gray(dut_gray)
);

always @(*) begin assert (@(posedge clk) disable iff (!reset) (dut_gray == bcd ^ (bcd >> 1))); end

always @(*) begin assert (@(posedge clk) disable iff (!reset) ($countones(bcd) <= 4 && $countones(bcd) >= 0)); end

always @(*) begin assert (@(posedge clk) disable iff (!reset) ((bcd == 4'b0000) |-> (dut_gray == 4'b0000)); end
    @(posedge clk) disable iff (!reset) ((bcd == 4'b1001) |-> (dut_gray == 4'b1100)));

endmodule