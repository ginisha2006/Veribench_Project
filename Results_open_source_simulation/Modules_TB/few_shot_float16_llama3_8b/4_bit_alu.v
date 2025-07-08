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
    $display("Time	a	b	ALU_Sel	ALU_Result	Carry	Overflow	Zero");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%d	%b	%b	%b", $time, a, b, ALU_Sel, ALU_Result, Carry, Overflow, Zero);
    // Test Case 1: ADD with zero
    a = 0; b = 0; ALU_Sel = 3'b000; #10;
    // Test Case 2: ADD with non-zero
    a = 1; b = 1; ALU_Sel = 3'b000; #10;
    // Test Case 3: SUB with borrow
    a = 1; b = 1; ALU_Sel = 3'b001; #10;
    // Test Case 4: SUB without borrow
    a = 1; b = 0; ALU_Sel = 3'b001; #10;
    // Test Case 5: AND
    a = 1; b = 1; ALU_Sel = 3'b010; #10;
    // Test Case 6: OR
    a = 1; b = 1; ALU_Sel = 3'b011; #10;
    // Test Case 7: XOR
    a = 1; b = 1; ALU_Sel = 3'b100; #10;
    // Test Case 8: NOT
    a = 1; ALU_Sel = 3'b101; #10;
    // Test Case 9: Shift Left
    a = 1; ALU_Sel = 3'b110; #10;
    // Test Case 10: Shift Right
    a = 1; ALU_Sel = 3'b111; #10;
    // Finish the simulation
    $finish;
end
endmodule