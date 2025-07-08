module tb_seven_seg_display;

parameter DATA_WIDTH = 4;

input [DATA_WIDTH-1:0] data;
output reg [6:0] seg;

seven_seg_display dut (.data(data),.seg(seg));

property p_valid_data_range;
    ($onehot(data) && ($size(data) == DATA_WIDTH));
assert property (p_valid_data_range);

property p_segment_assignment;
    @(posedge clk) disable iff (!clk) ((data == 4'h0) => seg == 7'b1000000) ||
                                       ((data == 4'h1) => seg == 7'b1111001) ||
                                       ((data == 4'h2) => seg == 7'b0100100) ||
                                       ((data == 4'h3) => seg == 7'b0110000) ||
                                       ((data == 4'h4) => seg == 7'b0011001) ||
                                       ((data == 4'h5) => seg == 7'b0010010) ||
                                       ((data == 4'h6) => seg == 7'b0000010) ||
                                       ((data == 4'h7) => seg == 7'b1111000) ||
                                       ((data == 4'h8) => seg == 7'b0000000) ||
                                       ((data == 4'h9) => seg == 7'b0011000) ||
                                       ((data == 4'HA) => seg == 7'b0001000) ||
                                       ((data == 4'hB) => seg == 7'b0000011) ||
                                       ((data == 4'hC) => seg == 7'b1000110) ||
                                       ((data == 4'hD) => seg == 7'b0100001) ||
                                       ((data == 4'hE) => seg == 7'b0000110) ||
                                       ((data == 4'hF) => seg == 7'b0001110) ||
                                       (default: seg == 7'b1111111);
assert property (p_segment_assignment);

property p_no_overflow_underflow;
   !($rising_edge(clk) |-> $stable(data));
assert property (p_no_overflow_underflow);

property p_clock_rising_edge;
    $rose(clk);
assert property (p_clock_rising_edge);

property p_clock_falling_edge;
    $fell(clk);
assert property (p_clock_falling_edge);

endmodule