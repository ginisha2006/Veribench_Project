module tb_seven_seg_display (
    input [3:0] data,
    output reg [6:0] seg
);

reg clk;

always #5 clk = ~clk;

property p_valid_data;
    @(posedge clk) disable iff (!reset)
    data inside {[4'h0 : 4'hF]} |-> ##1 seg != 7'b1111111;
endproperty

assert property(p_valid_data);

property p_invalid_data;
    @(posedge clk) disable iff (!reset)
    data !== ([4'h0 : 4'hF]) |=> seg == 7'b1111111;
endproperty

assert property(p_invalid_data);

property p_edge_cases;
    @(posedge clk) disable iff (!reset)
    data === 4'h0 |-> seg == 7'b1000000;
    data === 4'h1 |-> seg == 7'b1111001;
    data === 4'h2 |-> seg == 7'b0100100;
    data === 4'h3 |-> seg == 7'b0110000;
    data === 4'h4 |-> seg == 7'b0011001;
    data === 4'h5 |-> seg == 7'b0010010;
    data === 4'h6 |-> seg == 7'b0000010;
    data === 4'h7 |-> seg == 7'b1111000;
    data === 4'h8 |-> seg == 7'b0000000;
    data === 4'h9 |-> seg == 7'b0011000;
    data === 4'hA |-> seg == 7'b0001000;
    data === 4'hB |-> seg == 7'b0000011;
    data === 4'hC |-> seg == 7'b1000110;
    data === 4'hD |-> seg == 7'b0100001;
    data === 4'hE |-> seg == 7'b0000110;
    data === 4'hF |-> seg == 7'b0001110;
endproperty

assert property(p_edge_cases);

seven_seg_display dut (
    .data(data),
    .seg(seg)
);

endmodule