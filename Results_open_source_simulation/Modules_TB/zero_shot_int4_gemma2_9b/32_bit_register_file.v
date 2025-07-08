module reg_file_32bit_tb;

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

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    // Add your test sequences here
  end

  initial begin
    $monitor("Time: %t clk=%b rst=%b we=%b read_addr1=%d read_addr2=%d write_addr=%d write_data=%h read_data1=%h read_data2=%h", $time, clk, rst, we, read_addr1, read_addr2, write_addr, write_data, read_data1, read_data2);
  end

endmodule