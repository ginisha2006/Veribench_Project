module tb_counter;

  input clk;
  input reset;
  input ena;
  output [7:0] result;

  counter dut (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .result(result)
  );

  always @(*) begin assert (@(posedge clk) result == result + 1); end
  always @(*) begin assert (@(posedge reset) result == 0); end
  always @(*) begin assert (@(posedge clk) !ena && result == result); end

endmodule