module reg_file_32bit_tb();

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
    clk = 0; forever #5 clk = ~clk; end

  initial begin
    rst = 1; #10 rst = 0;
    
    // Test Case 1: Write and Read
    write_addr = 5'd0;
    write_data = 32'hABCDEF;
    we = 1; #10;
    read_addr1 = 5'd0;
    $display("Read Data 1: %h", read_data1);

    // Test Case 2: Read Multiple Addresses
    read_addr1 = 5'd10;
    read_addr2 = 5'd20;
    $display("Read Data 1: %h", read_data1);
    $display("Read Data 2: %h", read_data2);

    // Test Case 3: Write Different Addresses
    write_addr = 5'd15;
    write_data = 32'h12345678;
    we = 1; #10;
    $display("Write Address: %d", write_addr);

    // Test Case 4: Read After Writing
    read_addr1 = 5'd15;
    $display("Read Data 1: %h", read_data1);

  end
endmodule