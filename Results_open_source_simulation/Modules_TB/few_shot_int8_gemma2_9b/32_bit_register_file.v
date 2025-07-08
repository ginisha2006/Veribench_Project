module tb_reg_file_32bit;
  // Clock and Reset Signals
  reg clk;
  reg rst;
  // Write Enable Signal
  reg we;
  // Address Signals
  reg [4:0] read_addr1;
  reg [4:0] read_addr2;
  reg [4:0] write_addr;
  // Data Signals
  reg [31:0] write_data;
  wire [31:0] read_data1;
  wire [31:0] read_data2;

  // Instantiate the Register File
  reg_file_32bit uut (
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

  initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Initialize reset
    rst = 1;
    #10 rst = 0;

    // Test Cases
    // ... Your test cases here ...

    // Example Test Case:
    we = 1;
    write_addr = 5'd0;
    write_data = 32'hDEADBEEF;
    #10;
    read_addr1 = 5'd0;
    read_addr2 = 5'd10;
    #10;
    $display("Read data from address 0: %h", read_data1);
    $display("Read data from address 10: %h", read_data2);

    $finish;
  end
endmodule