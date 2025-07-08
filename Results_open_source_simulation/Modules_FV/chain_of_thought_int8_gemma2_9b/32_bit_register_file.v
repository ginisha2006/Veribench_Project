module tb_reg_file_32bit;

  logic clk;
  logic rst;
  logic we;
  logic [4:0] read_addr1;
  logic [4:0] read_addr2;
  logic [4:0] write_addr;
  logic [31:0] write_data;
  logic [31:0] read_data1;
  logic [31:0] read_data2;

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

  property p_write_operation;
    @(posedge clk)
      $past(we) && !we ? regs[write_addr] == write_data : true;
  endproperty

  property p_read_operation;
    @(posedge clk)
      read_data1 == regs[read_addr1] && read_data2 == regs[read_addr2];
  endproperty

  property p_address_range;
    read_addr1 >= 0 && read_addr1 <= 31 && read_addr2 >= 0 && read_addr2 <= 31 && write_addr >= 0 && write_addr <= 31;
  endproperty

  assert property(p_write_operation);
  assert property(p_read_operation);
  assert property(p_address_range);


endmodule