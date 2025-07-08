module tb_alu_4bit (
    input [3:0] a,
    input [3:0] b,
    input [2:0] ALU_Sel,
    output reg [3:0] ALU_Result,
    output Zero,
    output reg Carry,
    output reg Overflow
);

assert (@(posedge ALU_Sel) disable iff (!ALU_Sel)
   (ALU_Sel === 3'b000) |-> !((a[3] == b[3]) && (a[3] !== ALU_Result[3])));

assert (@(posedge ALU_Sel) disable iff (!ALU_Sel)
   (ALU_Sel === 3'b001) |-> !((a[3] !== b[3]) && (b[3] !== ALU_Result[3])));

assert (@(posedge ALU_Sel) disable iff (!ALU_Sel)
   (Zero === (ALU_Result === 4'b0)));

assert (@(posedge ALU_Sel) disable iff (!ALU_Sel)
   (ALU_Sel === 3'b000) |-> (Carry === (a[3] && b[3] && !(ALU_Result[3]))));

assert (@(posedge ALU_Sel) disable iff (!ALU_Sel)
   (ALU_Sel === 3'b001) |-> (Carry === (a[3] && !b[3] && !(ALU_Result[3]))));

assert (@(posedge ALU_Sel) disable iff (!ALU_Sel)
   (Overflow === (((ALU_Sel === 3'b000) && (a[3] == b[3]) && (ALU_Result[3] !== a[3])) ||
                  ((ALU_Sel === 3'b001) && (a[3] !== b[3]) && (ALU_Result[3] !== a[3])))));

assert (@(posedge ALU_Sel) disable iff (!ALU_Sel)
   (ALU_Sel === 3'b010) |-> (ALU_Result === (a & b)),
   (ALU_Sel === 3'b011) |-> (ALU_Result === (a | b)),
   (ALU_Sel === 3'b100) |-> (ALU_Result === (a ^ b)),
   (ALU_Sel === 3'b101) |-> (ALU_Result === (~a)),
   (ALU_Sel === 3'b110) |-> (ALU_Result === (a << 1)),
   (ALU_Sel === 3'b111) |-> (ALU_Result === (a >> 1)));

endmodule