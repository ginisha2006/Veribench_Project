module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
wire [ADDR_WIDTH-1:0] addr;
reg [ADDR_WIDTH-1:0] addr_r;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
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
    addr = 0;
    data_in = 0;
    we = 0;

    // Wait for some cycles before starting tests
    repeat(10) @posedge clk;

    // Test case 1: Write then read back
    addr = 3; data_in = 16'hDEAD; we = 1; @posedge clk;
    we = 0; @posedge clk;
    addr = 3; we = 0; @posedge clk;
    $display("Data at address %h should be %h, actual is %h", addr, 16'hDEAD, data_out);

    // Test case 2: Overwrite existing value
    addr = 3; data_in = 16'hBEEF; we = 1; @posedge clk;
    we = 0; @posedge clk;
    addr = 3; we = 0; @posedge clk;
    $display("Data at address %h should be %h, actual is %h", addr, 16'hBEEF, data_out);

    // Test case 3: Read from different addresses
    addr = 4; we = 0; @posedge clk;
    $display("Data at address %h should be %h, actual is %h", addr, 16'h0000, data_out);

    // Edge case: Address out of range
    addr = 7'b1111_111; we = 0; @posedge clk;
    $display("Data at address %b should be %h, actual is %h", addr, 16'h0000, data_out);

    // Corner case: Multiple writes in sequence
    addr = 5; data_in = 16'hCAFE; we = 1; @posedge clk;
    addr = 5; data_in = 16'hFACE; we = 1; @posedge clk;
    we = 0; @posedge clk;
    addr = 5; we = 0; @posedge clk;
    $display("Data at address %h should be %h, actual is %h", addr, 16'hFACE, data_out);

    // Finish simulation
    $finish;
end

endmodule