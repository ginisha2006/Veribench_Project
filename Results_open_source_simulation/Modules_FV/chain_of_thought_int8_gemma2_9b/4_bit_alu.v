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

  property add_overflow;
    @(posedge clk)
    (ALU_Sel == 3'b000) && ((a[3] == b[3]) && (ALU_Result[3] != a[3])) -> Overflow;
  endproperty

  property sub_overflow;
    @(posedge clk)
    (ALU_Sel == 3'b001) && ((a[3] == b[3]) && (ALU_Result[3] != a[3])) -> Overflow;
  endproperty

  property zero_result;
    @(posedge clk)
    (ALU_Result == 4'b0000) == Zero;
  endproperty

  property valid_alu_sel;
    @(posedge clk)
    ALU_Sel >= 3'b000 && ALU_Sel <= 3'b111;
  endproperty

  assert property(add_overflow);
  assert property(sub_overflow);
  assert property(zero_result);
  assert property(valid_alu_sel);


endmodule