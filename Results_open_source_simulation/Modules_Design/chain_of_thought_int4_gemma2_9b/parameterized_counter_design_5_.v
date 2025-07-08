module param_counter (
  input clk,
  input rst,
  output reg [7:0] count
);

  parameter MAX_COUNT = 255;

  always @(posedge clk) begin
    if (rst) begin
      count <= 0;
    end else if (count == MAX_COUNT) begin
      count <= 0;
    end else begin
      count <= count + 1;
    end
  end

endmodule