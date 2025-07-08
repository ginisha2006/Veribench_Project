module tb_alu_4bit;

  reg [3:0] a;
  reg [3:0] b;
  reg [2:0] ALU_Sel;
  wire [3:0] ALU_Result;
  wire Zero;
  wire Carry;
  wire Overflow;

  alu_4bit dut (
    .a(a),
    .b(b),
    .ALU_Sel(ALU_Sel),
    .ALU_Result(ALU_Result),
    .Zero(Zero),
    .Carry(Carry),
    .Overflow(Overflow)
  );

  assert (@(posedge clk)
      $past(ALU_Sel) == 3'b000 && ALU_Result == a + b);
  assert (@(posedge clk)
      $past(ALU_Sel) == 3'b001 && ALU_Result == a - b);
  assert (@(posedge clk)
      $past(ALU_Sel) == 3'b010 && ALU_Result == a & b);
  assert (@(posedge clk)
      $past(ALU_Sel) == 3'b011 && ALU_Result == a | b);
  assert (@(posedge clk)
      $past(ALU_Sel) == 3'b100 && ALU_Result == a ^ b);
  assert (@(posedge clk)
      $past(ALU_Sel) == 3'b101 && ALU_Result == ~a);
  assert (@(posedge clk)
      $past(ALU_Sel) == 3'b110 && ALU_Result == a << 1);
  assert (@(posedge clk)
      $past(ALU_Sel) == 3'b111 && ALU_Result == a >> 1);
  assert (@(posedge clk)
      ALU_Sel == 3'b000 && !Overflow);
  assert (@(posedge clk)
      Zero == (ALU_Result == 4'b0000));

  always #5 ALU_Sel = ALU_Sel + 1;

endmodule