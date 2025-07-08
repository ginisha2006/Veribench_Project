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
    $monitor("%0d	%b	%b	%b	%b	%d	%d	%d", $time, a, b, ALU_Sel, ALU_Result, Zero, Carry, Overflow);
    
    // Test various operations with different inputs
    a = 4'b0000; b = 4'b0000; ALU_Sel = 3'b000; #10; // ADD: 0+0
    a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b000; #10; // ADD: 1+1
    a = 4'b1111; b = 4'b0001; ALU_Sel = 3'b000; #10; // ADD: 15+1
    a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b001; #10; // SUB: 1-1
    a = 4'b0001; b = 4'b0010; ALU_Sel = 3'b001; #10; // SUB: 1-2
    a = 4'b0001; b = 4'b0000; ALU_Sel = 3'b010; #10; // AND: 1&0
    a = 4'b0001; b = 4'b0010; ALU_Sel = 3'b011; #10; // OR: 1|2
    a = 4'b0001; b = 4'b0010; ALU_Sel = 3'b100; #10; // XOR: 1^2
    a = 4'b0001; ALU_Sel = 3'b101; #10;              // NOT: ~1
    a = 4'b0001; ALU_Sel = 3'b110; #10;              // SHL: 1<<1
    a = 4'b0001; ALU_Sel = 3'b111; #10;              // SHR: 1>>1
    
    // Test overflow condition
    a = 4'b1111; b = 4'b0001; ALU_Sel = 3'b000; #10; // ADD: 15+1 should cause overflow
    
    // Finish the simulation
    $finish;
end
endmodule