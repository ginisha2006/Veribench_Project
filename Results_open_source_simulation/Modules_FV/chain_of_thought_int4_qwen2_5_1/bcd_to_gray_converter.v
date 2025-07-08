module tb_bcd_to_gray (
    input [3:0] bcd,
    output reg [3:0] gray,
    input clk
);

property p_valid_input;
    @(posedge clk) disable iff (!reset)
    $onehot(bcd[3:0]) |-> $stable(gray);
endproperty

assert property(p_valid_input);

property p_output_behavior;
    @(posedge clk) disable iff (!reset)
    gray == bcd ^ (bcd >> 1);
endproperty

assert property(p_output_behavior);

property p_edge_cases;
    @(posedge clk) disable iff (!reset)
    (bcd == 4'b0000) |-> (gray == 4'b0000);
    @(posedge clk) disable iff (!reset)
    (bcd == 4'b1001) |-> (gray == 4'b1001);
endproperty

assert property(p_edge_cases);

property p_overflow_underflow;
    @(posedge clk) disable iff (!reset)
    !($isunknown(bcd)) & !(bcd < 4'b0000) & !(bcd > 4'b1001);
endproperty

assert property(p_overflow_underflow);

endmodule