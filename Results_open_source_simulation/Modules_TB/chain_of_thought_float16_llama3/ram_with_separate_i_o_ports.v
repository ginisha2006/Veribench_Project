module ram_separate_io_tb;

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
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    $monitor($time, "Addr: %b, Data In: %h, We: %b, Data Out: %h", addr, data_in, we, data_out);
    #10;
    addr = 0;
    data_in = 8'h12;
    we = 1;
    #20;
    addr = 1;
    data_in = 8'h34;
    we = 1;
    #20;
    addr = 0;
    we = 0;
    #20;
    addr = 1;
    we = 0;
    #100;
    $display("Simulation complete");
    $finish;
end

endmodule