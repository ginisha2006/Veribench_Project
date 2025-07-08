module tb_alu_4bit;

logic [3:0] a;
logic [3:0] b;
logic [2:0] ALU_Sel;
logic [3:0] ALU_Result;
logic Zero;
logic Carry;
logic Overflow;

alu_4bit dut (
   .a(a),
   .b(b),
   .ALU_Sel(ALU_Sel),
   .ALU_Result(ALU_Result),
   .Zero(Zero),
   .Carry(Carry),
   .Overflow(Overflow)
);

property p_add_correct;
    @(posedge clk) disable iff (!rst_n) ($onehot({a, b}) && ALU_Sel == 3'b000) => ($onehot({ALU_Result == a + b}));
endproperty

property p_sub_correct;
    @(posedge clk) disable iff (!rst_n) ($onehot({a, b}) && ALU_Sel == 3'b001) => ($onehot({ALU_Result == a - b}));
endproperty

property p_and_correct;
    @(posedge clk) disable iff (!rst_n) ($onehot({a, b}) && ALU_Sel == 3'b010) => ($onehot({ALU_Result == a & b}));
endproperty

property p_or_correct;
    @(posedge clk) disable iff (!rst_n) ($onehot({a, b}) && ALU_Sel == 3'b011) => ($onehot({ALU_Result == a | b}));
endproperty

property p_xor_correct;
    @(posedge clk) disable iff (!rst_n) ($onehot({a, b}) && ALU_Sel == 3'b100) => ($onehot({ALU_Result == a ^ b}));
endproperty

property p_not_correct;
    @(posedge clk) disable iff (!rst_n) ($onehot({a}) && ALU_Sel == 3'b101) => ($onehot({ALU_Result == ~a}));
endproperty

property p_shl_correct;
    @(posedge clk) disable iff (!rst_n) ($onehot({a}) && ALU_Sel == 3'b110) => ($onehot({ALU_Result == a << 1}));
endproperty

property p_shr_correct;
    @(posedge clk) disable iff (!rst_n) ($onehot({a}) && ALU_Sel == 3'b111) => ($onehot({ALU_Result == a >> 1}));

property p_overflow_add;
    @(posedge clk) disable iff (!rst_n) ($onehot({a, b}) && ALU_Sel == 3'b000) && (a[3] == b[3]) && (ALU_Result[3]!= a[3]) => Overflow;
endproperty

property p_zero_output;
    @(posedge clk) disable iff (!rst_n) ($onehot({a, b}) && ALU_Result == 4'b0000) => Zero;
endproperty

property p_carry_output;
    @(posedge clk) disable iff (!rst_n) ($onehot({a, b}) && ALU_Sel == 3'b000) => Carry;
endproperty

initial begin
    #10 rst_n = 1;
    #20 rst_n = 0;
    #50 $finish;
end

endmodule