module tb_alu_4bit;

reg clk;
reg [3:0] a, b;
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

property p_add_correct;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b000) => (ALU_Result == (a + b)));
endproperty

property p_sub_correct;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b001) => (ALU_Result == (a - b))));
endproperty

property p_and_correct;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b010) => (ALU_Result == (a & b))));
endproperty

property p_or_correct;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b011) => (ALU_Result == (a | b))));
endproperty

property p_xor_correct;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b100) => (ALU_Result == (a ^ b))));
endproperty

property p_not_correct;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b101) => (ALU_Result == (~a))));
endproperty

property p_shl_correct;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b110) => (ALU_Result == (a << 1))));
endproperty

property p_shr_correct;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b111) => (ALU_Result == (a >> 1))));
endproperty

property p_overflow;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b000) && (a[3] == b[3]) && (ALU_Result[3]!= a[3]) => Overflow);
endproperty

property p_zero;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Result == 4'b0000) => Zero);
endproperty

initial begin
    #10 clk = 1'b0;
    forever #(20) clk = ~clk;
end

#50 $finish;

endmodule