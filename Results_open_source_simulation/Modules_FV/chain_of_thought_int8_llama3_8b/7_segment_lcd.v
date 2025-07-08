module tb_seven_seg_display;

parameter DATA_WIDTH = 4;

input [DATA_WIDTH-1:0] data;
output reg [6:0] seg;

seven_seg_display dut (
   .data(data),
   .seg(seg)
);

property p_correct_mapping;
    @(posedge clk) disable iff (!rst_n) ($onehot(seg) && (seg == 7'b1000000 => data == 4'h0) &&
                                    (seg == 7'b1111001 => data == 4'h1) &&
                                    (seg == 7'b0100100 => data == 4'h2) &&
                                    (seg == 7'b0110000 => data == 4'h3) &&
                                    (seg == 7'b0011001 => data == 4'h4) &&
                                    (seg == 7'b0010010 => data == 4'h5) &&
                                    (seg == 7'b0000010 => data == 4'h6) &&
                                    (seg == 7'b1111000 => data == 4'h7) &&
                                    (seg == 7'b0000000 => data == 4'h8) &&
                                    (seg == 7'b0011000 => data == 4'h9) &&
                                    (seg == 7'b0001000 => data == 4'hA) &&
                                    (seg == 7'b0000011 => data == 4'hB) &&
                                    (seg == 7'b1000110 => data == 4'hC) &&
                                    (seg == 7'b0100001 => data == 4'hD) &&
                                    (seg == 7'b0000110 => data == 4'hE) &&
                                    (seg == 7'b0001110 => data == 4'hF));
assert property(p_correct_mapping);

property p_default_value;
    @(posedge clk) disable iff (!rst_n) (seg!= 7'b1111111 || data!= 4'hF);
assert property(p_default_value);

property p_edge_cases;
    @(posedge clk) disable iff (!rst_n) ((seg[0] &&!seg[1]) | (seg[1] &&!seg[0]);
assert property(p_edge_cases);

property p_overflow_underflow;
    @(posedge clk) disable iff (!rst_n) ($unsigned(data) >= 4'h10);
assert property(p_overflow_underflow);

property p_illegal_transition;
    @(posedge clk) disable iff (!rst_n) (!(seg == 7'b1111111) |!(data == 4'hF));
assert property(p_illegal_transition);

endmodule