module tb_counter;

logic clk;
logic reset;
logic ena;
logic [7:0] result;

counter dut (.clk(clk),.reset(reset),.ena(ena),.result(result));

always @(*) begin assert (@(posedge clk) disable iff (!reset) result == 0); end
always @(*) begin assert (@(posedge clk) disable iff (reset |!ena) result == $past(result)); end
always @(*) begin assert ($rose(result[7]) |-> $fell(result[7])); end
always @(*) begin assert ($fell(result[7]) |-> $rose(result[7])); end

endmodule