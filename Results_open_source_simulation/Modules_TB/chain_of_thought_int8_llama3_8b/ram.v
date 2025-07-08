module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    #10 clk = 1'b0; // reset
    #20 clk = 1'1; // clock enable
    #100 $monitor($time, "Addr: %b, Data_in: %h, We: %b, Data_out: %h", addr, data_in, we, data_out);
    #200 we = 1'b1; // write cycle
    data_in = 8'h12;
    addr = 8'h03;
    #50 we = 1'b0; // read cycle
    #50 $display("Expected data out: %h", 8'h12);
    #100 $monitor($time, "Addr: %b, Data_in: %h, We: %b, Data_out: %h", addr, data_in, we, data_out);
    #500 $stop;
end

always #5 clk = ~clk; // clock generation

endmodule