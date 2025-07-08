module tb_bcd_to_gray (
    input clk,
    input [3:0] bcd,
    output reg [3:0] gray
);

wire [3:0] dut_gray;

bcd_to_gray #(.BCD_WIDTH(4), .GRAY_WIDTH(4)) uut (
    .bcd(bcd),
    .gray(dut_gray)
);

property p_valid_input;
    @(posedge clk) disable iff (!reset)
    ($countones(bcd) <= 4) |-> (dut_gray == bcd ^ (bcd >> 1));
endproperty

assert property(p_valid_input);

property p_no_overflow_underflow;
    @(posedge clk) disable iff (!reset)
    !$isunknown(bcd) |-> (!$isunknown(dut_gray));
endproperty

assert property(p_no_overflow_underflow);

property p_edge_cases;
    @(posedge clk) disable iff (!reset)
    (bcd == 4'b0000) |-> (dut_gray == 4'b0000);
    (bcd == 4'b0001) |-> (dut_gray == 4'b0001);
    (bcd == 4'b0010) |-> (dut_gray == 4'b0011);
    (bcd == 4'b0011) |-> (dut_gray == 4'b0010);
    (bcd == 4'b0100) |-> (dut_gray == 4'b0110);
    (bcd == 4'b0101) |-> (dut_gray == 4'b0111);
    (bcd == 4'b0110) |-> (dut_gray == 4'b0101);
    (bcd == 4'b0111) |-> (dut_gray == 4'b0100);
    (bcd == 4'b1000) |-> (dut_gray == 4'b1100);
    (bcd == 4'b1001) |-> (dut_gray == 4'b1101);
endproperty

assert property(p_edge_cases);

endmodule