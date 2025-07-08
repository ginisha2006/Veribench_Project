module tb_alu_4bit;
// Inputs
reg [3:0] a;
reg [3:0] b;
reg [2:0] ALU_Sel;
// Outputs
wire [3:0] ALU_Result;
wire Zero;
wire Carry;
wire Overflow;
// Instantiate the ALU
alu_4bit uut (
    .a(a), 
    .b(b), 
    .ALU_Sel(ALU_Sel), 
    .ALU_Result(ALU_Result), 
    .Zero(Zero), 
    .Carry(Carry), 
    .Overflow(Overflow)
);
initial begin
    // Display the header for the output
    $display("Time	a	b	ALU_Sel	ALU_Result	Zero	Carry	Overflow");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b	%b", $time, a, b, ALU_Sel, ALU_Result, Zero, Carry, Overflow);
    // Test Cases
    // Addition
    ALU_Sel = 3'b000; a = 4'b0011; b = 4'b0100; #10;
    ALU_Sel = 3'b000; a = 4'b1111; b = 4'b0001; #10;
    // Subtraction
    ALU_Sel = 3'b001; a = 4'b1010; b = 4'b0110; #10;
    ALU_Sel = 3'b001; a = 4'b0001; b = 4'b1111; #10;
    // Logical Operations
    ALU_Sel = 3'b010; a = 4'b1010; b = 4'b0110; #10;
    ALU_Sel = 3'b011; a = 4'b1010; b = 4'b0110; #10;
    ALU_Sel = 3'b100; a = 4'b1010; b = 4'b0110; #10;
    // Bitwise Operations
    ALU_Sel = 3'b101; a = 4'b1010; #10;
    ALU_Sel = 3'b110; a = 4'b0110; #10;
    ALU_Sel = 3'b111; a = 4'b0110; #10;
    // Finish the simulation
    $finish;
end
endmodule