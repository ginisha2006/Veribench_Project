Here is the SystemVerilog testbench code for the 7-segment display module:

module tb_seven_seg_display;

parameter DATA_WIDTH = 4;
reg clk;
reg [DATA_WIDTH-1:0] data;
wire [6:0] seg;

seven_seg_display uut (
   .data(data),
   .seg(seg)
);

property p_edge_cases;
    @(posedge clk) disable iff (!clk) (data === 4'h0 |=>!seg[0]);
    @(posedge clk) disable iff (!clk) (data === 4'h1 |=> seg[6]);
    @(posedge clk) disable iff (!clk) (data === 4'h2 |=> seg[5]);
    @(posedge clk) disable iff (!clk) (data === 4'h3 |=> seg[4]);
    @(posedge clk) disable iff (!clk) (data === 4'h4 |=> seg[3]);
    @(posedge clk) disable iff (!clk) (data === 4'h5 |=> seg[2]);
    @(posedge clk) disable iff (!clk) (data === 4'h6 |=> seg[1]);
    @(posedge clk) disable iff (!clk) (data === 4'h7 |=> seg[0]);
    @(posedge clk) disable iff (!clk) (data === 4'h8 |=> seg[6]);
    @(posedge clk) disable iff (!clk) (data === 4'h9 |=> seg[5]);
    @(posedge clk