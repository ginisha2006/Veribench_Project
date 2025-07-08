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

property p_data_width;
    @(posedge clk) disable iff (!clk) ($onehot(data[DATA_WIDTH-1:0]));
endproperty

property p_valid_data;
    @(posedge clk) disable iff (!clk) (|data);
endproperty

property p_invalid_data;
    @(posedge clk) disable iff (!clk) (~|data);
endproperty

property p_segment_selection;
    @(posedge clk) disable iff (!clk) ((data == 4'h0) |-> seg == 7'b1000000);
    @(posedge clk) disable iff (!clk) ((data == 4'h1) |-> seg == 7'b1111001);
    @(posedge clk) disable iff (!clk) ((data == 4'h2) |-> seg == 7'b0100100);
    @(posedge clk) disable iff (!chk) ((data == 4'h3) |-> seg == 7'b0110000);
    @(posedge clk) disable iff (!clk) ((data == 4'h4) |-> seg == 7'b0011001);
    @(posedge clk) disable iff (!clk) ((data == 4'h5) |-> seg == 7'b0010010);
    @(posedge clk) disable iff (!clk) ((data == 4'h6) |-> seg == 7'b0000010);
    @(posedge clk) disable iff (!clk) ((data == 4'h7) |-> seg == 7'b1111000);
    @(posedge clk) disable iff (!clk) ((data == 4'h8) |-> seg == 7'b0000000);
    @(posedge clk) disable iff (!clk) ((data == 4'h9) |-> seg == 7'b0011000);
    @(posedge clk) disable iff (!clk) ((data == 4'hA) |-> seg == 7'b0001000);
    @(posedge clk) disable iff (!clk) ((data == 4'hB) |-> seg == 7'b0000011);
    @(posedge clk) disable iff (!clk) ((data == 4'hC) |-> seg == 7'b1000110);
    @(posedge clk) disable iff (!clk) ((data == 4'hD) |-> seg == 7'b0100001);
    @(posedge clk) disable iff (!clk) ((data == 4'hE) |-> seg == 7'b0000110);
    @(posedge clk) disable iff (!clk) ((data == 4'hF) |-> seg == 7'b0001110);
    @(posedge clk) disable iff (!clk) ((data!= 4'h0 && data!= 4'h1 && data!= 4'h2 && data!= 4'h3 && data!= 4'h4 && data!= 4'h5 && data!= 4'h6 && data!= 4'h7 && data!= 4'h8 && data!= 4'h9 && data!= 4'hA && data!= 4'hB && data!= 4'hC && data!= 4'hD && data!= 4'hE && data!= 4'hF) |-> seg == 7'b1111111);
endproperty

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