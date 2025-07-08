module tb_counter;

logic clk;
logic reset;
logic ena;
logic [7:0] result;

counter dut (
   .clk(clk),
   .reset(reset),
   .ena(ena),
   .result(result)
);

property p_reset_value;
    @(posedge clk) disable iff (!reset) result == 0;
endproperty

property p_ena_transition;
    @(posedge clk) disable iff (!ena) ($fell(result));
endproperty

property p_ena_incr;
    @(posedge clk) disable iff (ena) result == $past(result) + 1;
endproperty

property p_overflow;
    @(posedge clk) disable iff (ena && result == 8'hff) $fell(result);
endproperty

property p_underflow;
    @(posedge clk) disable iff (ena && result == 8'h00) $rose(result);
endproperty

assert property (p_reset_value);
assert property (p_ena_transition);
assert property (p_ena_incr);
assert property (p_overflow);
assert property (p_underflow);

endmodule