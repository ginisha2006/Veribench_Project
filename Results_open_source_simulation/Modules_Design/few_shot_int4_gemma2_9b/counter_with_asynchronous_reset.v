module counter (
    input clk,
    input reset,
    input ena,
    output reg [7:0] result
);
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      result <= 0;
    end else if (ena) begin
      result <= result + 1;
    end
  end
endmodule