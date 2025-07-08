module tb_seven_seg_display;

parameter DATA_WIDTH = 4;
reg [DATA_WIDTH-1:0] data;
wire [6:0] seg;

seven_seg_display dut (
   .data(data),
   .seg(seg)
);

property p_data_validity;
   !($isunknown(data));
endproperty

property p_invalid_input;
   !(data >= 4'h10 && data <= 4'hF);
endproperty

property p_segment_output;
    @(posedge clk) disable iff (!clk) 
    (data == 4'h0 => seg == 7'b1000000) |
    (data == 4'h1 => seg == 7'b1111001) |
    (data == 4'h2 => seg == 7'b0100100) |
    (data == 4'h3 => seg == 7'b0110000) |
    (data == 4'h4 => seg == 7'b0011001) |
    (data == 4'h5 => seg == 7'b0010010) |
    (data == 4'h6 => seg == 7'b0000010) |
    (data == 4'h7 => seg == 7'b1111000) |
    (data == 4'h8 => seg == 7'b0000000) |
    (data == 4'h9 => seg == 7'b0011000) |
    (data == 4'hA => seg == 7'b0001000) |
    (data == 4'hB => seg == 7'b0000011) |
    (data == 4'hC => seg == 7'b1000110) |
    (data == 4'hD => seg == 7'b0100001) |
    (data == 4'hE => seg == 7'b0000110) |
    (data == 4'hF => seg == 7'b0001110) |
    (default => seg == 7'b1111111);
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!clk) 
    ($rose(data) | $fell(data));
endproperty

property p_overflow_underflow;
    @(posedge clk) disable iff (!clk) 
    (data > 4'hF || data < 4'h0);
endproperty

assert property (p_data_validity);
assert property (p_invalid_input);
assert property (p_segment_output);
assert property (p_edge_cases);
assert property (p_overflow_underflow);

endmodule