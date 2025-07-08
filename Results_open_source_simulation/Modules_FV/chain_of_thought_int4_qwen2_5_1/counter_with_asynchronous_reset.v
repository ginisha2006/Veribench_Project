module tb_counter (
    input clk,
    input reset,
    input ena,
    output reg [7:0] result
);
counter dut (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .result(result)
);

reg clk;
always #5 clk = ~clk;

property no_overflow;
 @(posedge clk) disable iff (!reset)
   !$isunknown(result) |-> result < 8'd256;
endproperty
assert property(no_overflow);

property reset_clears_result;
 @(posedge reset) disable iff (!reset)
   !reset |=> result == 8'b0;
endproperty
assert property(reset_clears_result);

property enable_increments_result;
 @(posedge clk) disable iff (!reset)
   ena ##1 result == result[7:0] + 1;
endproperty
assert property(enable_increments_result);

property no_increment_when_not_enabled;
 @(posedge clk) disable iff (!reset)
   !ena |=> result == result[7:0];
endproperty
assert property(no_increment_when_not_enabled);

endmodule