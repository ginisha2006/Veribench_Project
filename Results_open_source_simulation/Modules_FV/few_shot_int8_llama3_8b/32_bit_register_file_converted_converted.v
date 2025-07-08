module tb_reg_file_32bit();

  // Inputs
  reg clk, rst, we;
  reg [4:0] read_addr1, read_addr2, write_addr;
  reg [31:0] write_data;

  // Outputs
  wire [31:0] read_data1, read_data2;

  // Instantiate the DUT
  reg_file_32bit UUT (
   .clk(clk),
   .rst(rst),
   .we(we),
   .read_addr1(read_addr1),
   .read_addr2(read_addr2),
   .write_addr(write_addr),
   .write_data(write_data),
   .read_data1(read_data1),
   .read_data2(read_data2)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset all registers to zero
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Property: Check if register values are updated correctly
  always @(*) begin always @(*) begin assert (@(posedge clk) ($rose(we) && UUT.regs[UUT.write_addr] === UUT.write_data)); end end

  // Property: Check if read data is correct
  always @(*) begin always @(*) begin assert (@(posedge clk) (UUT.read_data1 === UUT.regs[UUT.read_addr1])); end end

  // Property: Check if read data is correct
  always @(*) begin always @(*) begin assert (@(posedge clk) (UUT.read_data2 === UUT.regs[UUT.read_addr2])); end end

endmodule