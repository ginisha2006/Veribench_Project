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
    
    // Test Case 1: Write to register 0
    write_addr = 5'd0;
    write_data = 32'hABCDEF01;
    we = 1;
    #10 we = 0;

    // Test Case 2: Read from register 0
    read_addr1 = 5'd0;
    read_addr2 = 5'd1;
    #10 
    $display("Read Data 1: %h", read_data1);
    $display("Read Data 2: %h", read_data2);

    // Test Case 3: Write to different register
    write_addr = 5'd16;
    write_data = 32'h12345678;
    we = 1;
    #10 we = 0;

    // Test Case 4: Read from both registers
    read_addr1 = 5'd0;
    read_addr2 = 5'd16;
    #10 
    $display("Read Data 1: %h", read_data1);
    $display("Read Data 2: %h", read_data2);
  end

endmodule