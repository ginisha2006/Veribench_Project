module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_separate_io #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    #100; // wait for clock to stabilize
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    #200; // wait for clock to stabilize
    we = 0;
    addr = 0;
    data_in = 8'h12;
    #10;
    we = 1;
    #10;
    we = 0;
    #20;
    addr = 4;
    data_in = 8'h34;
    #10;
    we = 1;
    #10;
    we = 0;
    #20;
    addr = 0;
    #10;
    $display("Expected data_out: %h", 8'h12);
    $display("Actual   data_out: %h", data_out);
    #100;
    $display("Expected data_out: %h", 8'h34);
    $display("Actual   data_out: %h", data_out);
    #100;
    $display("Expected data_out: %h", 8'h12);
    $display("Actual   data_out: %h", data_out);
end

always @(*) begin
    $monitor($time, "clk=%b, we=%b, addr=%h, data_in=%h, data_out=%h", clk, we, addr, data_in, data_out);
end

endmodule