module tb_alu_4bit;
// Parameters
parameter WIDTH = 4;
// Inputs
reg [3:0] a;
reg [3:0] b;
reg [2:0] ALU_Sel;
// Outputs
wire [3:0] ALU_Result;
wire Zero;
wire Carry;
wire Overflow;
// Instantiate the 4-bit ALU
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
    $display("Time	a		b	ALU_Sel	ALU_Result	Carry	Overflow	Zero");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b	%b", $time, a, b, ALU_Sel, ALU_Result, Carry, Overflow, Zero);
    // Test all possible input combinations
    // Test ADD
    a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b000; #10;
    a = 4'b1111; b = 4'b1111; ALU_Sel = 3'b000; #10;
    // Test SUB
    a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b001; #10;
    a = 4'b1111; b = 4'b1111; ALU_Sel = 3'b001; #10;
    // Test AND
    a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b010; #10;
    a = 4'b1111; b = 4'b1111; ALU_Sel = 3'b010; #10;
    // Test OR
    a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b011; #10;
    a = 4'b1111; b = 4'b1111; ALU_Sel = 3'b011; #10;
    // Test XOR
    a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b100; #10;
    a = 4'b1111; b = 4'b1111; ALU_Sel = 3'b100; #10;
    // Test NOT
    a = 4'b0001; ALU_Sel = 3'b101; #10;
    a = 4'b1111; ALU_Sel = 3'b101; #10;
    // Test Left Shift
    a = 4'b0001; ALU_Sel = 3'b110; #10;
    a = 4'b1111; ALU_Sel = 3'b110; #10;
    // Test Right Shift
    a = 4'b0001; ALU_Sel = 3'b111; #10;
    a = 4'b1111; ALU_Sel = 3'b111; #10;
    // Test Overflow
    a = 4'b1111; b = 4'b1111; ALU_Sel = 3'b000; #10;
    // Finish the simulation
    $finish;
end
endmodule