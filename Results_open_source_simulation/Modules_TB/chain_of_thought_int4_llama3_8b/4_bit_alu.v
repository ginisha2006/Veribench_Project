alu_4bit_testbench; 

parameter WIDTH = 4;

reg [WIDTH-1:0] a, b;

reg [2:0] ALU_Sel;

wire [WIDTH-1:0] ALU_Result;

wire Zero;

wire reg Carry;

wire reg Overflow;

initial begin

#10;

$monitor($time, "a=%b, b=%b, ALU_Sel=%b, ALU_Result=%b, Zero=%b, Carry=%b, Overflow=%b", a, b, ALU_Sel, ALU_Result, Zero, Carry, Overflow);

#20;

a <= 4'b0000;

b <= 4'b0000;

ALU_Sel <= 3'b000;

#50;

assert(Zero == 1);

assert(Carry == 0);

assert(Overflow == 0);

#20;

a <= 4'b1111;

b <= 4'b1111;

ALU_Sel <= 3'b000;

#50;

assert(ALU_Result == 4'b1110);

assert(Carry == 1);

assert(Overflow == 0);

#20;

a <= 4'b1111;

b <= 4'b0000;

ALU_Sel <= 3'b000;

#50;

assert(ALU_Result == 4'b1111);

assert(Carry == 1);

assert(Overflow == 0);

#20;

a <= 4'b0000;

b <= 4'b1111;

ALU_Sel <= 3'b000;

#50;

assert(ALU_Result == 4'b1111);

assert(Carry == 1);

assert(Overflow == 0);

#20;

a <= 4'b1111;

b <= 4'b1111;

ALU_Sel <= 3'b001;

#50;

assert(ALU_Result == 4'b0000);

assert(Carry == 1);

assert(Overflow == 0);

#20;

a <= 4'b1111;

b <= 4'b0000;

ALU_Sel <= 3'b001;

#50;

assert(ALU_Result == 4'b1111);

assert(Carry == 0);

assert(Overflow == 0);

#20;

a <= 4'b0000;

b <= 4'b1111;

ALU_Sel <= 3'b001;

#50;

assert(ALU_Result == 4'b0000);

assert(Carry == 0);

assert(Overflow == 0);

#20;

a <= 4'b1111;

b <= 4'b1111;

ALU_Sel <= 3'b010;

#50;

assert(ALU_Result == 4'b1111);

#20;

a <= 4'b0000;

b <= 4'b0000;

ALU_Sel <= 3'b010;

#50;

assert(ALU_Result == 4'b0000);

#20;

a <= 4'b1111;

b <= 4'b1111;

ALU_Sel <= 3'b011;

#50;

assert(ALU_Result == 4'b1111);

#20;

a <= 4'b0000;

b <= 4'b0000;

ALU_Sel <= 3'b011;

#50;

assert(ALU_Result == 4'b0000);

#20;

a <= 4'b1111;

b <= 4'b1111;

ALU_Sel <= 3'b100;

#50;

assert(ALU_Result == 4'b1110);

#20;

a <= 4'b0000;

b <= 4'b0000;

ALU_Sel <= 3'b100;

#50;

assert(ALU_Result == 4'b0000);

#20;

a <= 4'b1111;

b <= 4'b1111;

ALU_Sel <= 3'b101;

#50;