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
    #5 clk = 0; // reset
    repeat (100) begin
        #10 clk = ~clk;
    end
    #10 $finish;
end

initial begin
    we = 0;
    addr = 0;
    data_in = 8'h12;
    #20 we = 1;
    #10 addr = 4;
    #10 we = 0;
    #20 data_in = 8'h34;
    #10 addr = 4;
    #10 we = 1;
    #10 addr = 0;
    #10 we = 0;
    #50 $display("Expected data_out: %h", 8'h12);
    #10 $display("Actual   data_out: %h", data_out);
    #10 $display("Expected data_out: %h", 8'h34);
    #10 $display("Actual   data_out: %h", data_out);
    #10 $finish;
end

always @ (posedge clk) begin
    $monitor($time, "clk=%b, we=%b, addr=%h, data_in=%h, data_out=%h", clk, we, addr, data_in, data_out);
end

endmodule