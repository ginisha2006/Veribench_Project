module tb_counter;

  reg clk;
  reg reset;
  reg ena;
  wire [7:0] result;

  counter dut (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .result(result)
  );

  always @(*) begin assert (@(posedge clk) result == result + 1); end
  always @(*) begin assert (@(posedge reset) result == 0); end
  always @(*) begin assert (!((result == 8'hFF) && (ena)) || ((result == 8'h00) && (ena))); end

  always #5 clk = ~clk;

endmodule