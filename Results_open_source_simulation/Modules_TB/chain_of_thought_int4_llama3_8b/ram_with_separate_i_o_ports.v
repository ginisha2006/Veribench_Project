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
    #10; // delay for setup
    clk = 0;
    repeat (20) #5 ~clk = ~clk; // clock toggle

    // write some values
    addr = 0;
    data_in = 8'h12;
    we = 1;
    #10;
    addr = 1;
    data_in = 8'h34;
    we = 1;
    #10;
    addr = 0;
    we = 0;
    #10;

    // read back written values
    addr = 0;
    #10;
    $display($time, "Data Out: %h", data_out);

    // check for correct read value
    assert(data_out == 8'h12);

    // write another value
    addr = 1;
    data_in = 8'h56;
    we = 1;
    #10;
    addr = 1;
    #10;
    $display($time, "Data Out: %h", data_out);

    // check for correct read value
    assert(data_out == 8'h56);

    // reset the memory
    addr = 0;
    we = 1;
    data_in = 8'bx;
    #10;
    addr = 0;
    we = 0;
    #10;

    // check for default value after reset
    addr = 0;
    #10;
    $display($time, "Data Out: %h", data_out);

    // check for default value after reset
    assert(data_out == 8'h0);

    $finish;
end

always @(posedge clk) begin
    $monitor("Time: %t, Clk: %b, We: %b, Addr: %h, Data In: %h, Data Out: %h",
             $time, clk, we, addr, data_in, data_out);
end

endmodule