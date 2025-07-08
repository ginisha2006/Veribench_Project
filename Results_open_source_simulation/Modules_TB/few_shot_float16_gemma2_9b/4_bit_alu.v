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
    // ADD
    a = 4'b0010; b = 4'b0101; ALU_Sel = 3'b000; #10;
    // SUB
    a = 4'b1011; b = 4'b0110; ALU_Sel = 3'b001; #10;
    // AND
    a = 4'b1100; b = 4'b0011; ALU_Sel = 3'b010; #10;
    // OR
    a = 4'b0001; b = 4'b1110; ALU_Sel = 3'b011; #10;
    // XOR
    a = 4'b0101; b = 4'b1010; ALU_Sel = 3'b100; #10;
    // NOT
    a = 4'b1011; ALU_Sel = 3'b101; #10;
    // SHL
    a = 4'b0010; ALU_Sel = 3'b110; #10;
    // SHR
    a = 4'b1101; ALU_Sel = 3'b111; #10;
    // Finish the simulation
    $finish;
end
endmodule