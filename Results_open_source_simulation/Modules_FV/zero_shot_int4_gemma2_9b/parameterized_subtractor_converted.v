module tb_param_subtractor;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] diff;
  wire borrow;

  param_subtractor #(WIDTH) dut (a, b, diff, borrow);

  always @(*) begin assert (@(posedge clk) diff == a - b); end
  always @(*) begin assert (@(posedge clk) (a > b) && (diff[WIDTH-1] == 1'b1)); end
  always @(*) begin assert (@(posedge clk) (b > a) && (diff[WIDTH-1] == 1'b0)); end

endmodule