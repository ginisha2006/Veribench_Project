module tb_gray_count (
    input clk,
    input enable,
    input reset,
    output reg [7:0] gray_count
);
    
wire clk_wire;
reg enable_wire;
reg reset_wire;

gray_count dut (
    .clk(clk_wire),
    .enable(enable_wire),
    .reset(reset_wire),
    .gray_count(gray_count)
);

always #5 clk_wire = !clk_wire;

assert (@(posedge reset_wire) disable iff (!reset_wire)
   gray_count == 8'b0 && $past(q[-1]) === 1);

assert (@(posedge clk_wire) disable iff (!enable_wire || reset_wire)
   gray_count !== $past(gray_count));

assert (@(posedge clk_wire) disable iff (reset_wire)
   !$isunknown(gray_count) && gray_count >= 8'b0 && gray_count <= 8'b11111111);

assert (@(posedge clk_wire) disable iff (reset_wire)
   $stable(gray_count[7]) -> !(gray_count[7] ^ gray_count[6]));

assert (@(posedge clk_wire) disable iff (reset_wire)
   gray_count != {gray_count[6], gray_count[7]} ^ gray_count[6:0]);

endmodule