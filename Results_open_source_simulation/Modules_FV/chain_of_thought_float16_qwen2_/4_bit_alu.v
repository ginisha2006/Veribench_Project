module tb_alu_4bit (
    input [3:0] a,
    input [3:0] b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output Zero,
    output reg Carry,
    output reg Overflow
);

property p_add_no_carry;
 @(posedge ALU_Sel) disable iff (!ALU_Sel[2])
 (ALU_Sel === 3'b000) |-> !Carry inside {[0]} ##1 ALU_Result == a + b;
endproperty
assert property(p_add_no_carry)

property p_sub_no_borrow;
 @(posedge ALU_Sel) disable iff (!ALU_Sel[2])
 (ALU_Sel === 3'b001) |-> !Carry inside {[1]} ##1 ALU_Result == a - b;
endproperty
assert property(p_sub_no_borrow)

property p_and_or_xor_not_shl_shr;
 @(posedge ALU_Sel) disable iff (!ALU_Sel[2])
 (ALU_Sel inside {3'b010, 3'b011, 3'b100, 3'b101, 3'b110, 3'b111}) |-> 
     ##1 ALU_Result == (ALU_Sel === 3'b010) ? a & b :
                      (ALU_Sel === 3'b011) ? a | b :
                      (ALU_Sel === 3'b100) ? a ^ b :
                      (ALU_Sel === 3'b101) ? ~a :
                      (ALU_Sel === 3'b110) ? a << 1 :
                                             a >> 1;
endproperty
assert property(p_and_or_xor_not_shl_shr)

property p_overflow;
 @(posedge ALU_Sel) disable iff (!ALU_Sel[2])
 (ALU_Sel === 3'b000) |-> Overflow == (a[3] == b[3]) && (ALU_Result[3] != a[3]);
endproperty
assert property(p_overflow)

property p_zero;
 @(posedge ALU_Sel) disable iff (!ALU_Sel[2])
 (Zero == (ALU_Result == 4'b0000));
endproperty
assert property(p_zero)

endmodule