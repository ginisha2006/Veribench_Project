module tb_alu_4bit();

  // Inputs
  reg [3:0] a, b;
  reg [2:0] ALU_Sel;
  reg clk;

  // Outputs
  wire [3:0] ALU_Result;
  wire Zero;
  wire Carry;
  wire Overflow;

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
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b000) |-> (ALU_Result === a + b)); end

  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b000) |-> (Overflow === ((a[3] == b[3]) && (ALU_Result[3] != a[3])))); end

  // SUB Operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b001) |-> (ALU_Result === a - b)); end

  // AND Operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b010) |-> (ALU_Result === a & b)); end

  // OR Operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b011) |-> (ALU_Result === a | b)); end

  // XOR Operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b100) |-> (ALU_Result === a ^ b)); end

  // NOT Operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b101) |-> (ALU_Result === ~a)); end

  // SHL Operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b110) |-> (ALU_Result === a << 1)); end

  // SHR Operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b111) |-> (ALU_Result === a >> 1)); end

  // Zero Detection
  always @(*) begin assert (@(posedge clk) (ALU_Result == 4'b0000) |-> (Zero === 1); end
    @(posedge clk) (ALU_Result !== 4'b0000) |-> (Zero === 0));

endmodule