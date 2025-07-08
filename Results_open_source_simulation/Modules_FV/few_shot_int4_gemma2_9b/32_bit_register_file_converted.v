module tb_reg_file_32bit();

  // Inputs
  reg clk;
  reg rst;
  reg we;
  reg [4:0] read_addr1, read_addr2, write_addr;
  reg [31:0] write_data;

  // Outputs
  wire [31:0] read_data1, read_data2;

  // Instantiate the register file
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

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset pulse
  initial begin
    #10 rst = 1;
    #10 rst = 0;
  end

  // Assertions
  always @(*) begin assert (@(posedge clk) (we && (regs[write_addr] != write_data)) -> (regs[write_addr] == write_data)); end

  always @(*) begin assert (@(posedge clk) (read_data1 == regs[read_addr1]) && (read_data2 == regs[read_addr2])); end

  always @(*) begin assert (@(posedge clk) (read_addr1 >= 0) && (read_addr1 < 32) && (read_addr2 >= 0) && (read_addr2 < 32) && (write_addr >= 0) && (write_addr < 32)); end



endmodule