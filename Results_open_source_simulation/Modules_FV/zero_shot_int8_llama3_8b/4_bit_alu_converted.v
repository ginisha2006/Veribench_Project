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

assert property add_property;
assert property sub_property;
assert property and_property;
assert property or_property;
assert property xor_property;
assert property not_property;
assert property shl_property;
assert property shr_property;
assert property zero_property;
assert property carry_property;
assert property overflow_property;

endmodule