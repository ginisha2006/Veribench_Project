module tb_reg_file_32bit();

  // Clock and reset signals
  reg clk;
  reg rst;
  reg we;
  reg [4:0] read_addr1, read_addr2, write_addr;
  reg [31:0] write_data;

  // Output signals
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

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset sequence
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Write data to register
  initial begin
    write_addr = 0;
    write_data = 32'h12345678;
    we = 1;
    #10 we = 0;
  end

  // Read data from registers
  always @(*) begin assert (@(posedge clk) (read_data1 == 32'h12345678)); end

  always @(*) begin assert (@(posedge clk) (read_data2 == 32'h0)); end

  // Check read data after writing to another register
  initial begin
    write_addr = 1;
    write_data = 32'h98765432;
    we = 1;
    #10 we = 0;
  end

  always @(*) begin assert (@(posedge clk) (read_data1!= 32'h12345678)); end

  always @(*) begin assert (@(posedge clk) (read_data2 == 32'h0)); end

endmodule