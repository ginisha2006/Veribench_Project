module tb_alu_4bit;

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

property add_property;
    @(posedge clk) disable iff (!rst_n) ($onehot(ALU_Sel) && (|{a, b}) <= 4'd7) => 
        ($onehot(ALU_Sel) && (|{a, b}) > 4'd7) |-> ##1 (~Overflow);
endproperty

property sub_property;
    @(posedge clk) disable iff (!rst_n) ($onehot(ALU_Sel) && (|{a, b}) >= 4'd8) => 
        ($onehot(ALU_Sel) && (|{a, b}) < 4'd8) |-> ##1 (~Overflow);
endproperty

property and_property;
    @(posedge clk) disable iff (!rst_n) ($onehot(ALU_Sel) && (a & b) == a) => 
        (~a | ~b) |-> ##1 (ALU_Result == a);
endproperty

property or_property;
    @(posedge clk) disable iff (!rst_n) ($onehot(ALU_Sel) && (a | b) == a) => 
        (~a & ~b) |-> ##1 (ALU_Result == a);
endproperty

property xor_property;
    @(posedge clk) disable iff (!rst_n) ($onehot(ALU_Sel) && (a ^ b) == a) => 
        (~a & b) | (~a & ~b) | (~b & a) |-> ##1 (ALU_Result == a);
endproperty

property not_property;
    @(posedge clk) disable iff (!rst_n) ($onehot(ALU_Sel) && ~a) => 
        ALU_Result == ~a;
endproperty

property shl_property;
    @(posedge clk) disable iff (!rst_n) ($onehot(ALU_Sel) && a[3] == 0) => 
        ALU_Result == a << 1;
endproperty

property shr_property;
    @(posedge clk) disable iff (!rst_n) ($onehot(ALU_Sel) && a[0] == 0) => 
        ALU_Result == a >> 1;
endproperty

property zero_property;
    @(posedge clk) disable iff (!rst_n) (ALU_Result == 4'b0000) => 
        Zero;
endproperty

property carry_property;
    @(posedge clk) disable iff (!rst_n) (ALU_Sel == 3'b000 || ALU_Sel == 3'b101) => 
        Carry;
endproperty

property overflow_property;
    @(posedge clk) disable iff (!rst_n) (ALU_Sel == 3'b000 && (a[3] == b[3] && ALU_Result[3]!= a[3])) => 
        Overflow;
endproperty

assert property add_property;
assert property sub_property;
assert property and_property;
assert property or_property;
assert property xor_property;
assert property not_property;
assert property shl_property;
assert property shr_property;
assert property zero_property;
assert property carry_property;
assert property overflow_property;

endmodule