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

assert (@(posedge clk)
 disable iff(reset)
 ALU_Sel == 3'b000 |-> !Overflow);

assert (@(posedge clk)
 disable iff(reset)
 ALU_Sel == 3'b000 |-> ({5{a}}+{5{b}})[4:0] === {Carry, ALU_Result});

assert (@(posedge clk)
 disable iff(reset)
 ALU_Sel == 3'b001 |-> !Overflow);

assert (@(posedge clk)
 disable iff(reset)
 ALU_Sel == 3'b001 |-> ({5{a}}-{5{b}})[4:0] === {Carry, ALU_Result});

assert (@(posedge clk)
 disable iff(reset)
 (ALU_Sel inside {3'b010, 3'b011, 3'b100, 3'b101, 3'b110, 3'b111}) |-> !(Zero));

assert (@(posedge clk)
 disable iff(reset)
 ALU_Sel == 3'b000 & (a[3] == b[3]) & (ALU_Result[3] !== a[3]) |-> Overflow);

assert (@(posedge clk)
 disable iff(reset)
 ALU_Result == 4'b0000 |-> Zero);

endmodule