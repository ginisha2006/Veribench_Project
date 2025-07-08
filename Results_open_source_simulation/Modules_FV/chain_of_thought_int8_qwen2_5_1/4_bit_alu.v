module tb_alu_4bit (
    input [3:0] a,
    input [3:0] b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output Zero,
    output reg Carry,
    output reg Overflow
);

wire clk;
reg reset;

assign clk = 1'b1; // For simplicity, assume constant clock for assertion purposes

property add_no_overflow;
 @(posedge clk)
 disable iff(reset)
 ALU_Sel == 3'b000 |-> !Overflow;
endproperty

assert property(add_no_overflow);

property add_correct_result;
 @(posedge clk)
 disable iff(reset)
 ALU_Sel == 3'b000 |-> ({5{a}}+{5{b}})[4:0] === {Carry, ALU_Result};
endproperty

assert property(add_correct_result);

property sub_no_overflow;
 @(posedge clk)
 disable iff(reset)
 ALU_Sel == 3'b001 |-> !Overflow;
endproperty

assert property(sub_no_overflow);

property sub_correct_result;
 @(posedge clk)
 disable iff(reset)
 ALU_Sel == 3'b001 |-> ({5{a}}-{5{b}})[4:0] === {Carry, ALU_Result};
endproperty

assert property(sub_correct_result);

property and_or_xor_not_shl_shr_zero;
 @(posedge clk)
 disable iff(reset)
 (ALU_Sel inside {3'b010, 3'b011, 3'b100, 3'b101, 3'b110, 3'b111}) |-> !(Zero);
endproperty

assert property(and_or_xor_not_shl_shr_zero);

property overflow_addition;
 @(posedge clk)
 disable iff(reset)
 ALU_Sel == 3'b000 & (a[3] == b[3]) & (ALU_Result[3] !== a[3]) |-> Overflow;
endproperty

assert property(overflow_addition);

property zero_output;
 @(posedge clk)
 disable iff(reset)
 ALU_Result == 4'b0000 |-> Zero;
endproperty

assert property(zero_output);

endmodule