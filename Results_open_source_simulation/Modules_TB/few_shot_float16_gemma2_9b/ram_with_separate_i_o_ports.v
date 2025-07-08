module tb_ram_separate_io;
// Parameters
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;
// Clock
reg clk;
// Inputs
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
// Outputs
wire [DATA_WIDTH-1:0] data_out;
// Instantiate the RAM
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
    clk = 0; forever #5 clk = ~clk;
end
initial begin
    // Initialize data
    data_in = 0;
    // Test Cases
    we = 0; addr = 0; #10;
    data_in = 8'hAA; we = 1; addr = 0; #10;
    data_in = 8'hBB; we = 1; addr = 1; #10;
    we = 0; addr = 0; #10;
    $display("Data at address 0: %h", data_out);
    we = 0; addr = 1; #10;
    $display("Data at address 1: %h", data_out);
    $finish;
end
endmodule