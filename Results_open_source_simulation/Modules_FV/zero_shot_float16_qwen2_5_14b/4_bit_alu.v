module tb_alu_4bit (
    input clk,
    input [3:0] a,
    input [3:0] b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output Zero,
    output reg Carry,
    output reg Overflow
);

alu_4bit dut (
    .clk(clk),
    .a(a),
    .b(b),
    .ALU_Sel(ALU_Sel),
    .ALU_Result(ALU_Result),
    .Zero(Zero),
    .Carry(Carry),
    .Overflow(Overflow)
);

property p_add_no_carry;
 @(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b000) |-> !Carry inside {[0 : 1]};
endproperty
assert property(p_add_no_carry);

property p_sub_no_borrow;
 @(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b001) |-> !Carry inside {[0 : 1]};
endproperty
assert property(p_sub_no_borrow);

property p_and_zero;
 @(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b010) |-> (a & b == 4'b0000) -> Zero;
endproperty
assert property(p_and_zero);

property p_or_not_zero;
 @(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b011) |-> !(a | b == 4'b0000) -> !Zero;
endproperty
assert property(p_or_not_zero);

property p_xor_nonzero;
 @(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b010) |-> (a & b == 4'b0000) -> !Zero;
endproperty
assert property(p_xor_nonzero);

property p_not_result;
 @(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b011) |-> (~a == ALU_Result);
endproperty
assert property(p_not_result);

property p_shl_result;
 @(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b100) |-> (a << 1 == ALU_Result);
endproperty
assert property(p_shl_result);

property p_shr_result;
 @(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b101) |-> (a >> 1 == ALU_Result);
endproperty
assert property(p_shr_result);

property p_overflow_add;
 @(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b000) |-> (a[3] == b[3]) && (ALU_Result[3] != a[3]) -> Overflow;
endproperty
assert property(p_overflow_add);

property p_overflow_sub;
 @(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b001) |-> (a[3] != b[3]) && (ALU_Result[3] == a[3]) -> !Overflow;
endproperty
assert property(p_overflow_sub);

endmodule