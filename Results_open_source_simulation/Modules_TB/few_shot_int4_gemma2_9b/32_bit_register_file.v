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
    // Clock generation
    clk = 0; forever #5 clk = ~clk;
    // Reset pulse
    rst = 1; #10 rst = 0;
    // Test Cases
    // ...
    $finish;
  end

endmodule