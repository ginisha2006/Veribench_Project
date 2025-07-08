module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

initial begin
    #100; // wait for 100 time units
    clk = 0;
    forever #5 clk = ~clk; // clock at 50 MHz
end

initial begin
    #200; // wait for 200 time units
    we = 1; addr = 4'd3; data_in = 8'h12; // write operation
    #10;
    we = 0; addr = 4'd2; data_in = 8'h34; // write operation
    #10;
    we = 1; addr = 4'd3; // read operation
    #10;
    we = 0; addr = 4'd2; // read operation
    #10;
    we = 1; addr = 4'd7; data_in = 8'h56; // write operation out of bounds
    #10;
    we = 0; addr = 4'd15; // read operation out of bounds
    #100; // wait for 100 time units
    we = 0; addr = 4'd3; // read operation
    #10;
    we = 0; addr = 4'd2; // read operation
    #10;
    we = 0; addr = 4'd7; // read operation out of bounds
    #10;
    we = 0; addr = 4'd15; // read operation out of bounds
    $monitor($time, "Addr: %b, Data In: %h, We: %b, Data Out: %h", addr, data_in, we, data_out);
end

ram_separate_io uut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

endmodule