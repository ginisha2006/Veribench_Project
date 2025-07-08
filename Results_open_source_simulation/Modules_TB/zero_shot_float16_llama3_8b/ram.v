module ram_simple_tb;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) uut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    #5 clk = 0; // reset
    repeat (100) begin
        #10 clk = ~clk; // toggle clock
        addr = 0;
        data_in = 16'hA2; // write some data
        we = 1;
        #10 we = 0;
        #20 addr = 4; // read from different address
        we = 0;
        #10;
        $display("Address %d: Data Out = %h", addr, data_out);
    end
    #100 $finish;
end

always #5 clk = ~clk; // clock generation

$monitor($time, "Clk = %b, Addr = %d, We = %b, Data In = %h, Data Out = %h", clk, addr, we, data_in, data_out);

endmodule