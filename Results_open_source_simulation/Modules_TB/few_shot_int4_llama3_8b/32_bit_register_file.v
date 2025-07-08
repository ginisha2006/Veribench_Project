timescale 1ns / 1ps
module tb_reg_file_32bit;
// Clock and reset signals
reg clk;
reg rst;
// Write enable signal
reg we;
// Read addresses
reg [4:0] read_addr1;
reg [4:0] read_addr2;
reg [4:0] write_addr;
// Write data
reg [31:0] write_data;
// Read data
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
    clk = 0; rst = 0;
    #20;

    // Reset the register file
    rst = 1; #10;
    rst = 0;

    // Write some values into the register file
    write_addr = 0; write_data = 32'h00000001; we = 1; #10;
    write_addr = 1; write_data = 32'h00000002; we = 1; #10;
    write_addr = 2; write_data = 32'h00000003; we = 1; #10;
    write_addr = 3; write_data = 32'h00000004; we = 1; #10;
    write_addr = 4; write_data = 32'h00000005; we = 1; #10;
    write_addr = 5; write_data = 32'h00000006; we = 1; #10;
    write_addr = 6; write_data = 32'h00000007; we = 1; #10;
    write_addr = 7; write_data = 32'h00000008; we = 1; #10;
    write_addr = 8; write_data = 32'h00000009; we = 1; #10;
    write_addr = 9; write_data = 32'h00000010; we = 1; #10;
    write_addr = 10; write_data = 32'h00000011; we = 1; #10;
    write_addr = 11; write_data = 32'h00000012; we = 1; #10;
    write_addr = 12; write_data = 32'h00000013; we = 1; #10;
    write_addr = 13; write_data = 32'h00000014; we = 1; #10;
    write_addr = 14; write_data = 32'h00000015; we = 1; #10;
    write_addr = 15; write_data = 32'h00000016; we = 1; #10;
    write_addr = 16; write_data = 32'h00000017; we = 1; #10;
    write_addr = 17; write_data = 32'h00000018; we = 1; #10;
    write_addr = 18; write_data = 32'h00000019; we = 1; #10;
    write_addr = 19; write_data = 32'h00000020; we = 1; #10;
    write_addr = 20; write_data = 32'h00000021; we = 1; #10;
    write_addr = 21; write_data = 32'h00000022; we = 1; #10;
    write_addr = 22; write_data = 32'h00000023; we = 1; #10;
    write_addr = 23; write_data = 32'h00000024; we = 1; #10;
    write_addr = 24; write_data = 32'h00000025; we = 1; #10;
    write_addr = 25; write_data = 32'h00000026; we = 1; #10;
    write_addr = 26; write_data = 32'h00000027; we = 1; #10;
    write_addr = 27; write_data = 32'h00000028; we = 1; #10;
    write_addr = 28; write_data = 32'h00000029; we = 1; #10;
    write_addr = 29; write_data = 32'h00000030; we = 1; #10;
    write_addr = 30; write_data = 32'h00000031; we = 1; #10;