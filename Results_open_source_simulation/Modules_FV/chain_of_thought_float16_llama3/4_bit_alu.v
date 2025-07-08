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

property p_add_correctness;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b000) => (ALU_Result == a + b));
endproperty

property p_sub_correctness;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b001) => (ALU_Result == a - b)));
endproperty

property p_and_correctness;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b010) => (ALU_Result == a & b)));
endproperty

property p_or_correctness;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b011) => (ALU_Result == a | b)));
endproperty

property p_xor_correctness;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b100) => (ALU_Result == a ^ b)));
endproperty

property p_not_correctness;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b101) => (ALU_Result == ~a)));
endproperty

property p_shl_correctness;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b110) => (ALU_Result == a << 1)));
endproperty

property p_shr_correctness;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b111) => (ALU_Result == a >> 1)));

property p_overflow_detection;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) && (ALU_Sel == 3'b000) && (a[3] == b[3]) && (ALU_Result[3]!= a[3]) => Overflow);

property p_zero_detection;
    @(posedge clk) assert property (@(negedge clk) ($onehot(ALU_Sel) => Zero == (ALU_Result == 4'b0000));

default clocking @posedge(clk); endclocking

initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

endmodule