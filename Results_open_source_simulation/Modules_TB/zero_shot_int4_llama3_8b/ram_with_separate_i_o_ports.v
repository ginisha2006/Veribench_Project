timescale 1ns / 100ps;

module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_separate_io #(
   .DATA_WIDTH(DATA_WIDTH),
   .ADDR_WIDTH(ADDR_WIDTH)
) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;

    // Initialize memory
    for (int i = 0; i < 2**ADDR_WIDTH; i++) begin
        ram_separate_io.ram[i] = 0;
    end

    // Test read and write operations
    #10;
    addr = 0;
    data_in = 8'h12;
    we = 1;
    #10;
    $display("Expected value at address %d is %h", addr, 8'h12);
    $monitor($time, "addr=%b, data_in=%h, we=%b, data_out=%h", addr, data_in, we, data_out);

    #10;
    addr = 1;
    data_in = 8'h34;
    we = 1;
    #10;
    $display("Expected value at address %d is %h", addr, 8'h34);
    $monitor($time, "addr=%b, data_in=%h, we=%b, data_out=%h", addr, data_in, we, data_out);

    #10;
    addr = 0;
    data_in = 8'h56;
    we = 1;
    #10;
    $display("Expected value at address %d is %h", addr, 8'h56);
    $monitor($time, "addr=%b, data_in=%h, we=%b, data_out=%h", addr, data_in, we, data_out);

    #10;
    addr = 1;
    data_in = 8'h78;
    we = 0;
    #10;
    $display("Expected value at address %d is %h", addr, 8'h78);
    $monitor($time, "addr=%b, data_in=%h, we=%b, data_out=%h", addr, data_in, we, data_out);

    #20;
    addr = 0;
    data_in = 8'h90;
    we = 0;
    #10;
    $display("Expected value at address %d is %h", addr, 8'h90);
    $monitor($time, "addr=%b, data_in=%h, we=%b, data_out=%h", addr, data_in, we, data_out);

    #10;
    addr = 1;
    data_in = 8'hAB;
    we = 1;
    #10;
    $display("Expected value at address %d is %h", addr, 8'hAB);
    $monitor($time, "addr=%b, data_in=%h, we=%b, data_out=%h", addr, data_in, we, data_out);

    #10;
    addr = 0;
    data_in = 8'hCD;
    we = 0;
    #10;
    $display("Expected value at address %d is %h", addr, 8'hCD);
    $monitor($time, "addr=%b, data_in=%h, we=%b, data_out=%h", addr, data_in, we, data_out);

    #10;
    addr = 1;
    data_in = 8'hEF;
    we = 1;
    #10;
    $display("Expected value at address %d is %h", addr, 8'hEF);
    $monitor($time, "addr=%b, data_in=%h, we=%b, data_out=%h", addr, data_in, we, data_out);

    #10;
    addr = 0;
    data_in = 8'hc0;
    we = 0;
    #10;
    $display("Expected value at address %d is %h", addr, 8'hc0);
    $monitor($time, "addr=%b, data_in=%h, we=%b, data_out=%h", addr, data_in, we, data_out);

    #10;
    addr = 1;
    data_in = 8'h12;
    we = 0;
    #10;
    $display("Expected value at address %d is %h", addr, 8'h12);
    $monitor($time