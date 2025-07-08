module tb_ternary_adder_tree;

  parameter WIDTH = 16;

  reg [WIDTH-1:0] A, B, C, D, E;
  reg CLK;
  wire [WIDTH-1:0] OUT;

  ternary_adder_tree dut (A, B, C, D, E, CLK, OUT);

  always @(*) begin assert (@(posedge CLK) sumreg2 == (A + B + C + D + E)); end
  always @(*) begin assert (@(posedge CLK) OUT != {OUT[WIDTH-1], OUT[WIDTH-2:0]}); end
  always @(*) begin assert (@(posedge CLK) OUT != {1'b0, OUT[WIDTH-2:0]}); end

  always #5 CLK = ~CLK;

endmodule