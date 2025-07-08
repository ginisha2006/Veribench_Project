module counter (
  input clk,
  input reset,
  input ena,
  output reg [7:0] result
);

  always @(posedge clk) begin
    if (reset) begin
      result <= 8'b0;
    end else if (ena) begin
      result <= result + 1;
    end
  end

endmodule