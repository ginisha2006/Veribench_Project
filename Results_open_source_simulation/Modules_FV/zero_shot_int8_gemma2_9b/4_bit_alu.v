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

  property add_correctness;
    @(posedge clk)
    $past(a) + $past(b) == ALU_Result;
  endproperty

  property sub_correctness;
    @(posedge clk)
    $past(a) - $past(b) == ALU_Result;
  endproperty

  property and_correctness;
    @(posedge clk)
    $past(a) & $past(b) == ALU_Result;
  endproperty

  property or_correctness;
    @(posedge clk)
    $past(a) | $past(b) == ALU_Result;
  endproperty

  property xor_correctness;
    @(posedge clk)
    $past(a) ^ $past(b) == ALU_Result;
  endproperty

  property not_correctness;
    @(posedge clk)
    ~ $past(a) == ALU_Result;
  endproperty

  property shl_correctness;
    @(posedge clk)
    $past(a) << 1 == ALU_Result;
  endproperty

  property shr_correctness;
    @(posedge clk)
    $past(a) >> 1 == ALU_Result;
  endproperty

  property overflow_add;
    @(posedge clk)
    !(ALU_Sel == 3'b000) || !( (a[3] == b[3]) && (ALU_Result[3] != a[3]) );
  endproperty

  always #5 clk = ~clk;

  initial begin
    clk = 1'b0;
    a = 4'b0001;
    b = 4'b0010;
    ALU_Sel = 3'b000;
    #10;
    a = 4'b1111;
    b = 4'b0001;
    ALU_Sel = 3'b000;
    #10;
    a = 4'b1010;
    b = 4'b0101;
    ALU_Sel = 3'b001;
    #10;
    a = 4'b1111;
    b = 4'b1111;
    ALU_Sel = 3'b010;
    #10;
    a = 4'b0001;
    b = 4'b0010;
    ALU_Sel = 3'b011;
    #10;
    a = 4'b1010;
    b = 4'b0101;
    ALU_Sel = 3'b100;
    #10;
    a = 4'b1111;
    ALU_Sel = 3'b101;
    #10;
    a = 4'b0001;
    ALU_Sel = 3'b110;
    #10;
    a = 4'b0010;
    ALU_Sel = 3'b111;
    #10;
  end

  assert property(add_correctness);
  assert property(sub_correctness);
  assert property(and_correctness);
  assert property(or_correctness);
  assert property(xor_correctness);
  assert property(not_correctness);
  assert property(shl_correctness);
  assert property(shr_correctness);
  assert property(overflow_add);

endmodule