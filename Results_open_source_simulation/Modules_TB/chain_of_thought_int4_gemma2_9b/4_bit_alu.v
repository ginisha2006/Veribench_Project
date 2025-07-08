module alu_4bit_tb;

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

  initial begin
    $monitor("Time: %t, a: %h, b: %h, ALU_Sel: %h, ALU_Result: %h, Zero: %b, Carry: %b, Overflow: %b", $time, a, b, ALU_Sel, ALU_Result, Zero, Carry, Overflow);
    a = 4'b0011;
    b = 4'b1010;
    ALU_Sel = 3'b000;
    #10;
    a = 4'b1111;
    b = 4'b0001;
    ALU_Sel = 3'b001;
    #10;
    a = 4'b1010;
    b = 4'b0101;
    ALU_Sel = 3'b010;
    #10;
    a = 4'b0110;
    b = 4'b1001;
    ALU_Sel = 3'b011;
    #10;
    a = 4'b0001;
    b = 4'b1110;
    ALU_Sel = 3'b100;
    #10;
    a = 4'b1011;
    ALU_Sel = 3'b101;
    #10;
    a = 4'b0100;
    ALU_Sel = 3'b110;
    #10;
    a = 4'b1101;
    ALU_Sel = 3'b111;
    #10;
  end

endmodule