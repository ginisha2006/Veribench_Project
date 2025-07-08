module tb_reg_file_32bit;
// Clock and Reset
reg clk;
reg rst;
// Write Enable
reg we;
// Read Addresses
reg [4:0] read_addr1;
reg [4:0] read_addr2;
reg [4:0] write_addr;
// Write Data
reg [31:0] write_data;
// Read Data
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
    // Initialize clock and reset
    clk = 0; rst = 1; #20; rst = 0;
    // Initialize write enable
    we = 0;
    // Initialize read addresses
    read_addr1 = 0; read_addr2 = 0;
    write_addr = 0;
    // Initialize write data
    write_data = 32'h12345678;
    // Display the header for the output
    $display("Time	read_addr1	read_addr2	write_addr	write_data	read_data1	read_data2");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%h	%h", $time, read_addr1, read_addr2, write_addr, write_data, read_data1, read_data2);
    // Test Case 1: Write and read
    #10; we = 1; write_addr = 1; write_data = 32'h87654321; #10; we = 0;
    #10; read_addr1 = 1; read_addr2 = 0; #10;
    // Test Case 2: Write and read different addresses
    #10; we = 1; write_addr = 2; write_data = 32'hfedcba98; #10; we = 0;
    #10; read_addr1 = 1; read_addr2 = 2; #10;
    // Test Case 3: Write and read same address
    #10; we = 1; write_addr = 1; write_data = 32'habcd1234; #10; we = 0;
    #10; read_addr1 = 1; read_addr2 = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule