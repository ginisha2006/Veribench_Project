module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_separate_io #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk; // Clock generation
end

initial begin
    #10 addr = 4'b0000; data_in = 8'd10; we = 1; // Write operation
    #10 addr = 4'b0001; data_in = 8'd20; we = 1; // Write operation
    #10 addr = 4'b0010; data_in = 8'd30; we = 1; // Write operation
    #10 addr = 4'b0000; we = 0;               // Read operation
    #10 addr = 4'b0001; we = 0;               // Read operation
    #10 addr = 4'b0010; we = 0;               // Read operation
    #10 addr = 4'b1111; we = 0;               // Out-of-bounds read
    #10 addr = 4'b0000; data_in = 8'd40; we = 1; // Overwrite existing value
    #10 addr = 4'b0000; we = 0;               // Read overwritten value
    #10 addr = 4'b0001; data_in = 8'd50; we = 1; // Edge case write
    #10 addr = 4'b0001; we = 0;               // Read after edge case write
    #10 addr = 4'b1110; data_in = 8'd60; we = 1; // Near max address write
    #10 addr = 4'b1110; we = 0;               // Read near max address
    #10 addr = 4'b0000; we = 0;               // Final read for verification
    #10 $finish;
end

always @(posedge clk) begin
    $monitor($time," ns | CLK=%b ADDR=%d WE=%b DIN=%d DOUT=%d", clk, addr, we, data_in, data_out);
end

endmodule