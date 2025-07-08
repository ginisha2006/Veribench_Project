module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
wire [ADDR_WIDTH-1:0] addr;
reg [ADDR_WIDTH-1:0] addr_r;
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
    forever #5 clk = ~clk;
end

initial begin
    // Initialize signals
    addr_r = 0;
    data_in = 0;
    we = 0;

    // Reset phase
    repeat(10) @(negedge clk);

    // Test write operation
    for(int i=0; i<2**(ADDR_WIDTH); i=i+1) begin
        addr = i;
        data_in = i;
        we = 1;
        @(negedge clk);
        we = 0;
        @(negedge clk);
    end
    
    // Test read operation
    for(int i=0; i<2**(ADDR_WIDTH); i=i+1) begin
        addr = i;
        @(negedge clk);
        $display("Address %d, Data Out %h", i, data_out);
    end

    // Edge case - out-of-bounds address
    addr = 2**(ADDR_WIDTH)-1 + 1;
    @(negedge clk);
    $display("Out-of-Bounds Address %d, Data Out %h", 2**(ADDR_WIDTH)-1 + 1, data_out);

    // Corner case - simultaneous read/write on same address
    addr = 0;
    data_in = 16'hDEAD;
    we = 1;
    @(negedge clk);
    we = 0;
    @(negedge clk);
    
    // Verify correct value after simultaneous RW
    @(negedge clk);
    $display("Simultaneous RW at Addr 0, Data Out %h", data_out);

    // Finish simulation
    $finish;
end

endmodule