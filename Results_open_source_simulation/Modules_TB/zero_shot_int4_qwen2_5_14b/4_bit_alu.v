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
        $monitor($time, " ns: a=%b, b=%b, sel=%b, result=%b, zero=%b, carry=%b, overflow=%b", a, b, ALU_Sel, ALU_Result, Zero, Carry, Overflow);

        // Test ADD
        a = 4'b0001;
        b = 4'b0010;
        ALU_Sel = 3'b000;
        #5;

        // Test SUB
        a = 4'b0010;
        b = 4'b0001;
        ALU_Sel = 3'b001;
        #5;

        // Test AND
        a = 4'b1010;
        b = 4'b1100;
        ALU_Sel = 3'b010;
        #5;

        // Test OR
        a = 4'b1010;
        b = 4'b1100;
        ALU_Sel = 3'b011;
        #5;

        // Test XOR
        a = 4'b1010;
        b = 4'b1100;
        ALU_Sel = 3'b100;
        #5;

        // Test NOT
        a = 4'b1010;
        ALU_Sel = 3'b101;
        #5;

        // Test SHL
        a = 4'b1010;
        ALU_Sel = 3'b110;
        #5;

        // Test SHR
        a = 4'b1010;
        ALU_Sel = 3'b111;
        #5;

        // Edge Case: Add with overflow
        a = 4'b1111;
        b = 4'b0001;
        ALU_Sel = 3'b000;
        #5;

        // Edge Case: Subtract with borrow
        a = 4'b0001;
        b = 4'b1111;
        ALU_Sel = 3'b001;
        #5;

        // Corner Case: All zeros
        a = 4'b0000;
        b = 4'b0000;
        ALU_Sel = 3'b000;
        #5;

        // Corner Case: All ones
        a = 4'b1111;
        b = 4'b1111;
        ALU_Sel = 3'b000;
        #5;

        $finish;
    end
endmodule