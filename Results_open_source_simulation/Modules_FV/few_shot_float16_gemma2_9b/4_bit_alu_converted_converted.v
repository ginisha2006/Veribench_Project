module tb_alu_4bit ();

  // Inputs
  reg [3:0] a, b;
  reg [2:0] ALU_Sel;
  reg clk;

  // Outputs
  wire [3:0] ALU_Result;
  wire Zero;
  wire Carry;
  wire Overflow;

  // Instantiate the ALU
  alu_4bit dut (
    .a(a),
    .b(b),
    .ALU_Sel(ALU_Sel),
    .ALU_Result(ALU_Result),
    .Zero(Zero),
    .Carry(Carry),
    .Overflow(Overflow)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Result == a + b)); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Result == a - b)); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Result == a & b)); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Result == a | b)); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Result == a ^ b)); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Result == ~a)); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Result == a << 1)); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Result == a >> 1)); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (!(ALU_Sel == 3'b000) || !((a[3] == b[3]) && (ALU_Result[3] != a[3])))); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (Zero == (ALU_Result == 4'b0000))); end end


endmodule