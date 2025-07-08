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

assert (@(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b000) |-> !Carry inside {[0 : 1]});

assert (@(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b001) |-> !Carry inside {[0 : 1]});

assert (@(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b010) |-> (a & b == 4'b0000) -> Zero);

assert (@(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b011) |-> !(a | b == 4'b0000) -> !Zero);

assert (@(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b010) |-> (a & b == 4'b0000) -> !Zero);

assert (@(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b011) |-> (~a == ALU_Result));

assert (@(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b100) |-> (a << 1 == ALU_Result));

assert (@(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b101) |-> (a >> 1 == ALU_Result));

assert (@(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b000) |-> (a[3] == b[3]) && (ALU_Result[3] != a[3]) -> Overflow);

assert (@(posedge clk) disable iff (!ALU_Sel[2:0])
   (ALU_Sel[2:0] == 3'b001) |-> (a[3] != b[3]) && (ALU_Result[3] == a[3]) -> !Overflow);

endmodule