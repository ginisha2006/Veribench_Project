module tb_alu_4bit;
    reg [3:0] a;
    reg [3:0] b;
    reg [2:0] ALU_Sel;
    wire [3:0] ALU_Result;
    wire Zero;
    wire Carry;
    wire Overflow;

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
        #10;
        a = 4'b0000; b = 4'b0000; ALU_Sel = 3'b000; #10;
        a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b000; #10;
        a = 4'b1111; b = 4'b0001; ALU_Sel = 3'b000; #10;
        a = 4'b1111; b = 4'b0001; ALU_Sel = 3'b001; #10;
        a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b010; #10;
        a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b011; #10;
        a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b100; #10;
        a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b101; #10;
        a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b110; #10;
        a = 4'b0001; b = 4'b0001; ALU_Sel = 3'b111; #10;
        a = 4'b1111; b = 4'b0001; ALU_Sel = 3'b000; #10;
        a = 4'b1111; b = 4'b0001; ALU_Sel = 3'b001; #10;
        a = 4'b0000; b = 4'b0001; ALU_Sel = 3'b000; #10;
        a = 4'b0000; b = 4'b0001; ALU_Sel = 3'b001; #10;
        a = 4'b1111; b = 4'b0000; ALU_Sel = 3'b000; #10;
        a = 4'b1111; b = 4'b0000; ALU_Sel = 3'b001; #10;
        a = 4'b0000; b = 4'b0000; ALU_Sel = 3'b000; #10;
        a = 4'b0000; b = 4'b0000; ALU_Sel = 3'b001; #10;
        a = 4'b1111; b = 4'b1111; ALU_Sel = 3'b000; #10;
        a = 4'b1111; b = 4'b1111; ALU_Sel = 3'b001; #10;
        a = 4'b0000; b = 4'b0000; ALU_Sel = 3'b000; #10;
        a = 4'b0000; b = 4'b0000; ALU_Sel = 3'b001; #10;
        a = 4'b1111; b = 4'b0000; ALU_Sel = 3'b000; #10;
        a = 4'b1111; b = 4'b0000; ALU_Sel = 3'b001; #10;
        a