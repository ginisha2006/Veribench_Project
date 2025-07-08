module tb_reg_file_32bit();

  // Inputs
  reg clk;
  reg rst;
  reg we;
  reg [4:0] read_addr1;
  reg [4:0] read_addr2;
  reg [4:0] write_addr;
  reg [31:0] write_data;

  // Outputs
  wire [31:0] read_data1;
  wire [31:0] read_data2;

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

  // Properties
  property p_reset_all_registers;
    @(posedge clk) disable iff (!rst)
      rst |-> ##1 foreach (UUT.regs[i]) UUT.regs[i] == 32'b0;
  endproperty
  assert property (p_reset_all_registers);

  property p_write_enable;
    @(posedge clk) disable iff (!we || !rst)
      we && (##1 UUT.regs[write_addr] == write_data);
  endproperty
  assert property (p_write_enable);

  property p_read_data1;
    @(posedge clk) disable iff (!rst)
      read_addr1 inside {[0:31]} |-> read_data1 == UUT.regs[read_addr1];
  endproperty
  assert property (p_read_data1);

  property p_read_data2;
    @(posedge clk) disable iff (!rst)
      read_addr2 inside {[0:31]} |-> read_data2 == UUT.regs[read_addr2];
  endproperty
  assert property (p_read_data2);

endmodule