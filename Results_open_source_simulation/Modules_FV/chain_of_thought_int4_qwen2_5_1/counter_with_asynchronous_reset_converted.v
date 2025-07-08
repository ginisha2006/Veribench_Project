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

assert (@(posedge clk) disable iff (!reset)
   !$isunknown(result) |-> result < 8'd256);

assert (@(posedge reset) disable iff (!reset)
   !reset |=> result == 8'b0);

assert (@(posedge clk) disable iff (!reset)
   ena ##1 result == result[7:0] + 1);

assert (@(posedge clk) disable iff (!reset)
   !ena |=> result == result[7:0]);

endmodule