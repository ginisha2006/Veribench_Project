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
    $monitor($time, "a=%b, b=%b, ALU_Sel=%b, ALU_Result=%b, Zero=%b, Carry=%b, Overflow=%b", a, b, ALU_Sel, ALU_Result, Zero, Carry, Overflow);

    // Edge cases
    a = 4'hF; b = 4'hA; ALU_Sel = 3'b000; #20;
    a = 4'he; b = 4'hd; ALU_Sel = 3'b001; #20;
    a = 4'h8; b = 4'h0; ALU_Sel = 3'b010; #20;
    a = 4'h5; b = 4'h6; ALU_Sel = 3'b011; #20;
    a = 4'hC; b = 4'hD; ALU_Sel = 3'b100; #20;
    a = 4'h7; ALU_Sel = 3'b101; #20;
    a = 4'h8; ALU_Sel = 3'b110; #20;
    a = 4'h1; ALU_Sel = 3'b111; #20;

    // Corner cases
    a = 4'h0; b = 4'h0; ALU_Sel = 3'b000; #20;
    a = 4'hF; b = 4'hF; ALU_Sel = 3'b000; #20;
    a = 4'h0; b = 4'h1; ALU_Sel = 3'b001; #20;
    a = 4'hF; b = 4'hE; ALU_Sel = 3'b001; #20;
    a = 4'h0; b = 4'h0; ALU_Sel = 3'b010; #20;
    a = 4'hF; b = 4'hF; ALU_Sel = 3'b010; #20;
    a = 4'h0; b = 4'h1; ALU_Sel = 3'b011; #20;
    a = 4'hF; b = 4'hE; ALU_Sel = 3'b011; #20;
    a = 4'h0; b = 4'h0; ALU_Sel = 3'b100; #20;
    a = 4'hF; b = 4'hF; ALU_Sel = 3'b100; #20;
    a = 4'h0; b = 4'h1; ALU_Sel = 3'b101; #20;
    a = 4'hF; b = 4'hE; ALU_Sel = 3'b101; #20;
    a = 4'h0; b = 4'h0; ALU_Sel = 3'b110; #20;
    a = 4'hF; b = 4'hF; ALU_Sel = 3'b110; #20;
    a = 4'h0; b = 4'h1; ALU_Sel = 3'b111; #20;
    a = 4'hF; b = 4'hE; ALU_Sel = 3'b111; #20;

    #100 $finish;
end

endmodule