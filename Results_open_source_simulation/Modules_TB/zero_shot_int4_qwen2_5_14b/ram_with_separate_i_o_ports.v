module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
wire [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_separate_io #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) uut (
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
    addr = 4'b0000;
    data_in = 8'hAA;
    we = 0;
    repeat(10) @(posedge clk); // Wait for some cycles before starting tests
    
    // Test write operation
    we = 1;
    @(posedge clk);
    we = 0;
    
    // Read back written value
    @(posedge clk);
    $monitor("Cycle %d: Address %b, Data Out %h", $time, addr, data_out);
    
    // Change address and read again
    addr = 4'b0001;
    @(posedge clk);
    $monitor("Cycle %d: Address %b, Data Out %h", $time, addr, data_out);
    
    // Edge case - max address
    addr = 4'b1111;
    @(posedge clk);
    $monitor("Cycle %d: Address %b, Data Out %h", $time, addr, data_out);
    
    // Corner case - all zeros
    addr = 4'b0000;
    data_in = 8'h00;
    we = 1;
    @(posedge clk);
    we = 0;
    @(posedge clk);
    $monitor("Cycle %d: Address %b, Data Out %h", $time, addr, data_out);
    
    // Corner case - all ones
    addr = 4'b0000;
    data_in = 8'hFF;
    we = 1;
    @(posedge clk);
    we = 0;
    @(posedge clk);
    $monitor("Cycle %d: Address %b, Data Out %h", $time, addr, data_out);
    
    // Random access pattern
    for(int i=0; i<16; i++) begin
        addr = i;
        @(posedge clk);
        $monitor("Cycle %d: Address %b, Data Out %h", $time, addr, data_out);
    end
    
    $finish;
end

endmodule