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
    #10 a = 4'hF;
    #10 b = 4'hA;
    #10 ALU_Sel = 3'b000;
    @(posedge clock); $display("ADD: %h + %h = %h, Carry = %b, Overflow = %b", a, b, ALU_Result, Carry, Overflow);
    #10 a = 4'h5;
    #10 b = 4'h6;
    #10 ALU_Sel = 3'b001;
    @(posedge clock); $display("SUB: %h - %h = %h, Carry = %b, Overflow = %b", a, b, ALU_Result, Carry, Overflow);
    #10 a = 4'he;
    #10 b = 4'hd;
    #10 ALU_Sel = 3'b010;
    @(posedge clock); $display("AND: %h & %h = %h", a, b, ALU_Result);
    #10 a = 4'he;
    #10 b = 4'hc;
    #10 ALU_Sel = 3'b011;
    @(posedge clock); $display("OR: %h | %h = %h", a, b, ALU_Result);
    #10 a = 4'he;
    #10 b = 4'hd;
    #10 ALU_Sel = 3'b100;
    @(posedge clock); $display("XOR: %h ^ %h = %h", a, b, ALU_Result);
    #10 a = 4'h8;
    #10 ALU_Sel = 3'b101;
    @(posedge clock); $display("~%h = %h", a, ALU_Result);
    #10 a = 4'h8;
    #10 ALU_Sel = 3'b110;
    @(posedge clock); $display("%h << 1 = %h", a, ALU_Result);
    #10 a = 4'h8;
    #10 ALU_Sel = 3'b111;
    @(posedge clock); $display("%h >> 1 = %h", a, ALU_Result);
    #20 $finish;
end

always #10 clock = ~clock;

initial clock = 1'b0;

$monitor($time, "ALU_Result = %h, Zero = %b, Carry = %b, Overflow = %b", ALU_Result, Zero, Carry, Overflow);

endmodule