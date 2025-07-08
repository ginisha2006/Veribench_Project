timescale 1ns / 10ps

module tb_alu_4bit;

parameter WIDTH = 4;
reg [WIDTH-1:0] a, b;
reg [2:0] ALU_Sel;
wire [WIDTH-1:0] ALU_Result;
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
    #20; // delay for setup

    // Test ADD
    a = 4'h5; b = 4'h3; ALU_Sel = 3'b000;
    #50; $display("ADD: %h%b", ALU_Result); $monitor($time, "a=%b, b=%b, ALU_Sel=000, ALU_Result=%b, Carry=%b, Overflow=%b", a, b, ALU_Sel, ALU_Result, Carry, Overflow);

    // Test SUB
    a = 4'h5; b = 4'h3; ALU_Sel = 3'b001;
    #50; $display("SUB: %h%b", ALU_Result); $monitor($time, "a=%b, b=%b, ALU_Sel=001, ALU_Result=%b, Carry=%b, Overflow=%b", a, b, ALU_Sel, ALU_Result, Carry, Overflow);

    // Test AND
    a = 4'h5; b = 4'h3; ALU_Sel = 3'b010;
    #50; $display("AND: %h%b", ALU_Result); $monitor($time, "a=%b, b=%b, ALU_Sel=010, ALU_Result=%b, Carry=%b, Overflow=%b", a, b, ALU_Sel, ALU_Result, Carry, Overflow);

    // Test OR
    a = 4'h5; b = 4'h3; ALU_Sel = 3'b011;
    #50; $display("OR: %h%b", ALU_Result); $monitor($time, "a=%b, b=%b, ALU_Sel=011, ALU_Result=%b, Carry=%b, Overflow=%b", a, b, ALU_Sel, ALU_Result, Carry, Overflow);

    // Test XOR
    a = 4'h5; b = 4'h3; ALU_Sel = 3'b100;
    #50; $display("XOR: %h%b", ALU_Result); $monitor($time, "a=%b, b=%b, ALU_Sel=100, ALU_Result=%b, Carry=%b, Overflow=%b", a, b, ALU_Sel, ALU_Result, Carry, Overflow);

    // Test NOT
    a = 4'h5; ALU_Sel = 3'b101;
    #50; $display("NOT: %h%b", ALU_Result); $monitor($time, "a=%b, ALU_Sel=101, ALU_Result=%b, Carry=%b, Overflow=%b", a, ALU_Sel, ALU_Result, Carry, Overflow);

    // Test SHL
    a = 4'h5; ALU_Sel = 3'b110;
    #50; $display("SHL: %h%b", ALU_Result); $monitor($time, "a=%b, ALU_Sel=110, ALU_Result=%b, Carry=%b, Overflow=%b", a, ALU_Sel, ALU_Result, Carry, Overflow);

    // Test SHR
    a = 4'h5; ALU_Sel = 3'b111;
    #50; $display("SHR: %h%b", ALU_Result); $monitor($time, "a=%b, ALU_Sel=111, ALU_Result=%b, Carry=%b, Overflow=%b", a, ALU_Sel, ALU_Result, Carry, Overflow);

    // Test overflow
    a = 4'hF; b = 4'h1; ALU_Sel = 3'b000;
    #50; $display("Overflow: %b", Overflow); $monitor($time, "a=%b, b=%b, ALU_Sel=000, Overflow=%b", a, b, ALU_Sel, Overflow);

    // Test zero detection
    a = 4'h0; ALU_Sel = 3'b000;
    #50; $display("Zero: %b", Zero); $monitor($time