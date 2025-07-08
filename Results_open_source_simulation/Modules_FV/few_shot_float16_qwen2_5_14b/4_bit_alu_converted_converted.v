module tb_alu_4bit();

  // Inputs
  reg [3:0] a, b;
  reg [2:0] ALU_Sel;
  reg clk;

  // Outputs
  wire [3:0] ALU_Result;
  wire Zero;
  reg Carry;
  reg Overflow;

  // Instantiate the DUT
  alu_4bit UUT (
    .a(a),
    .b(b),
    .ALU_Sel(ALU_Sel),
    .ALU_Result(ALU_Result),
    .Zero(Zero),
    .Carry(Carry),
    .Overflow(Overflow)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties for each operation

  // ADD Operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b000) |-> (ALU_Result === a + b)); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b000) |-> (Carry === (a + b)[4])); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b000) |-> (Overflow === ((a[3] == b[3]) && (ALU_Result[3] != a[3])))); end end

  // SUB Operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b001) |-> (ALU_Result === a - b)); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b001) |-> (Carry === (a < b))); end end

  // AND Operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b010) |-> (ALU_Result === a & b)); end end

  // OR Operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b011) |-> (ALU_Result === a | b)); end end

  // XOR Operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b100) |-> (ALU_Result === a ^ b)); end end

  // NOT Operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b101) |-> (ALU_Result === ~a)); end end

  // SHL Operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b110) |-> (ALU_Result === a << 1)); end end

  // SHR Operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b111) |-> (ALU_Result === a >> 1)); end end

  // Zero Detection
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Result == 4'b0000) |-> (Zero === 1); end end
    @(posedge clk) (ALU_Result !== 4'b0000) |-> (Zero === 0));

endmodule