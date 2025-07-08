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

  always #5 clk = ~clk;
  reg clk;

  initial begin
    clk = 0;
  end

  assert property add_correctness;
  assert property sub_correctness;
  assert property and_correctness;
  assert property or_correctness;
  assert property xor_correctness;
  assert property not_correctness;
  assert property shl_correctness;
  assert property shr_correctness;
  assert property overflow_add;

endmodule