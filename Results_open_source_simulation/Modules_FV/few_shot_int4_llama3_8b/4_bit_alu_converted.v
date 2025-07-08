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

  // Property: Check ALU result for addition
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b000) => (ALU_Result == (a + b))); end

  // Property: Check ALU result for subtraction
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b001) => (ALU_Result == (a - b))); end

  // Property: Check ALU result for AND operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b010) => (ALU_Result == (a & b))); end

  // Property: Check ALU result for OR operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b011) => (ALU_Result == (a | b))); end

  // Property: Check ALU result for XOR operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b100) => (ALU_Result == (a ^ b))); end

  // Property: Check ALU result for NOT operation
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b101) => (ALU_Result == (~a))); end

  // Property: Check ALU result for left shift
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b110) => (ALU_Result == (a << 1))); end

  // Property: Check ALU result for right shift
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b111) => (ALU_Result == (a >> 1))); end

  // Property: Check overflow flag
  always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b000) && ((a[3] == b[3]) && (ALU_Result[3]!= a[3])) => Overflow); end

  // Property: Check zero flag
  always @(*) begin assert (@(posedge clk) (ALU_Result == 4'b0000) => Zero); end

endmodule