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

always @(*) begin assert (@(posedge clk) disable iff (!reset) result == 0); end
always @(*) begin assert (@(posedge clk) disable iff (!ena) ($fell(result))); end
always @(*) begin assert (@(posedge clk) disable iff (ena) result == $past(result) + 1); end
always @(*) begin assert (@(posedge clk) disable iff (ena && result == 8'hff) $fell(result)); end
always @(*) begin assert (@(posedge clk) disable iff (ena && result == 8'h00) $rose(result)); end

endmodule