timescale 1ns / 100ps

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
    #10; // delay for setup
    rst = 1; // reset
    repeat (5) @(posedge clk); // wait for 5 clock cycles
    rst = 0; // release reset
    #10; // delay for setup

    // Test writes
    write_addr = 3; // write to register 3
    write_data = 16'd12345;
    we = 1;
    @(posedge clk);
    we = 0;
    #10;

    write_addr = 15; // write to register 15
    write_data = 16'd67890;
    we = 1;
    @(posedge clk);
    we = 0;
    #10;

    // Test reads
    read_addr1 = 3; // read from register 3
    read_addr2 = 15; // read from register 15
    @(posedge clk);
    $monitor($time, "read_data1: %h", read_data1);
    $monitor($time, "read_data2: %h", read_data2);
    #20;

    // Test read-after-write
    write_addr = 7; // write to register 7
    write_data = 16'd11111;
    we = 1;
    @(posedge clk);
    we = 0;
    #10;
    read_addr1 = 7; // read from register 7
    read_addr2 = 15; // read from register 15
    @(posedge clk);
    $monitor($time, "read_data1: %h", read_data1);
    $monitor($time, "read_data2: %h", read_data2);
    #20;

    // Test read-before-write
    read_addr1 = 3; // read from register 3
    read_addr2 = 15; // read from register 15
    @(posedge clk);
    $monitor($time, "read_data1: %h", read_data1);
    $monitor($time, "read_data2: %h", read_data2);
    #10;
    write_addr = 3; // write to register 3
    write_data = 16'd22222;
    we = 1;
    @(posedge clk);
    we = 0;
    #10;
    read_addr1 = 3; // read from register 3
    read_addr2 = 15; // read from register 15
    @(posedge clk);
    $monitor($time, "read_data1: %h", read_data1);
    $monitor($time, "read_data2: %h", read_data2);
    #20;

    // Test edge cases
    write_addr = 31; // write to last register
    write_data = 16'd33333;
    we = 1;
    @(posedge clk);
    we = 0;
    #10;
    read_addr1 = 31; // read from last register
    read_addr2 = 15; // read from middle register
    @(posedge clk);
    $monitor($time, "read_data1: %h", read_data1);
    $monitor($time, "read_data2: %h", read_data2);
    #20;

    // Test corner case: read before write
    read_addr1 = 0; // read from first register
    read_addr2 = 15; // read from middle register
    @(posedge clk);
    $monitor($time, "read_data1: %h", read_data1);
    $monitor($time, "read_data2: %h", read_data2);
    #10;
    write_addr = 0; // write to first register
    write_data = 16'd44444;
    we = 1;
    @(posedge clk);
    we = 0;
    #10;
    read_addr1 = 0; // read from first register
    read_addr2 = 15; // read from middle register
    @(posedge clk);
    $monitor($