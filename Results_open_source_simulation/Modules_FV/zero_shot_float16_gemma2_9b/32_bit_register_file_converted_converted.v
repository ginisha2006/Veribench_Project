module tb_reg_file_32bit;

  reg clk;
  reg rst;
  reg we;
  reg [4:0] read_addr1;
  reg [4:0] read_addr2;
  reg [4:0] write_addr;
  reg [31:0] write_data;
  wire [31:0] read_data1;
  wire [31:0] read_data2;

  reg_file_32bit dut (
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

  always #5 clk = ~clk;

  assert (@(posedge clk) $past(read_addr1) != 5'h0 && $past(read_addr2) != 5'h0 &&
      read_data1 == regs[read_addr1] &&
      read_data2 == regs[read_addr2]);
  assert (@(posedge clk) we &&
      write_addr != 5'h0 &&
      regs[write_addr] == write_data);

endmodule