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

  // Property: Check if ALU result is correct for addition
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b000) -> ({Carry, ALU_Result} == a + b)); end end

  // Property: Check if ALU result is correct for subtraction
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b001) -> ({Carry, ALU_Result} == a - b)); end end

  // Property: Check if ALU result is correct for AND operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b010) -> (ALU_Result == a & b)); end end

  // Property: Check if ALU result is correct for OR operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b011) -> (ALU_Result == a | b)); end end

  // Property: Check if ALU result is correct for XOR operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b100) -> (ALU_Result == a ^ b)); end end

  // Property: Check if ALU result is correct for NOT operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b101) -> (ALU_Result == ~a)); end end

  // Property: Check if ALU result is correct for shift left operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b110) -> (ALU_Result == a << 1)); end end

  // Property: Check if ALU result is correct for shift right operation
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b111) -> (ALU_Result == a >> 1)); end end

  // Property: Check if Overflow flag is set correctly for addition
  always @(*) begin always @(*) begin assert (@(posedge clk) (ALU_Sel == 3'b000) -> (Overflow == ((a[3] == b[3]) && (ALU_Result[3]!= a[3])))); end end

  // Property: Check if Zero flag is set correctly
  always @(*) begin always @(*) begin assert (@(posedge clk) (Zero == (ALU_Result == 4'b0000))); end end

endmodule