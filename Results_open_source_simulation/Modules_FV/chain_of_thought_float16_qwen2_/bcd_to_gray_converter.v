module tb_bcd_to_gray (
    input [3:0] bcd,
    output reg [3:0] gray
);

wire clk;
reg [3:0] bcd_in;

assign gray = bcd_in ^ (bcd_in >> 1);

always begin
    clk = 1'b0;
    #(5) clk = 1'b1;
    #(5);
end

property p_valid_input;
    @(posedge clk) disable iff (!reset)
    ($past(bcd_in >= 0 && bcd_in <= 9)) |-> (gray == bcd_in ^ (bcd_in >> 1));
endproperty

assert property(p_valid_input);

property p_invalid_input;
    @(posedge clk) disable iff (!reset)
    (bcd_in > 9 || bcd_in < 0) |-> (gray === 4'bxxxx);
endproperty

assert property(p_invalid_input);

property p_edge_cases;
    @(posedge clk) disable iff (!reset)
    ((bcd_in == 4'd0) |-> (gray == 4'd0))
    and
    ((bcd_in == 4'd9) |-> (gray == 4'd8));
endproperty

assert property(p_edge_cases);

endmodule