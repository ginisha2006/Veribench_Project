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

  // Reset generation
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Assertions
  property p_write_operation;
    @(posedge clk) (we && (regs[write_addr] == write_data));
  endproperty
  assert property (p_write_operation);

  property p_read_operation;
    @(posedge clk) (read_data1 == regs[read_addr1]);
  endproperty
  assert property (p_read_operation);

  property p_read_operation2;
    @(posedge clk) (read_data2 == regs[read_addr2]);
  endproperty
  assert property (p_read_operation2);

endmodule