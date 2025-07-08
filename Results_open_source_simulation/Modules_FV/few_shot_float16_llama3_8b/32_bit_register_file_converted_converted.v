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

  // Property: Check if register values are updated correctly
  always @(*) begin always @(*) begin assert (@(posedge clk) ((we && (regs[write_addr]!= 32'h00000000)) => (regs[write_addr] == write_data))); end end

  // Property: Check if registers are reset correctly
  always @(*) begin always @(*) begin assert (@(posedge rst) (regs[31:0] == 32'h00000000)); end end

  // Property: Check if read data is correct
  always @(*) begin always @(*) begin assert (@(posedge clk) (read_data1 == regs[read_addr1])); end end

  always @(*) begin always @(*) begin assert (@(posedge clk) (read_data2 == regs[read_addr2])); end end

endmodule