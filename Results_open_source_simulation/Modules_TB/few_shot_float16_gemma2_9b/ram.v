module tb_ram_simple;
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
ram_simple #(
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
    // Initialize write enable and address
    we = 0; addr = 0;
    // Write some data
    data_in = 8'hAA; we = 1; addr = 0; #10;
    data_in = 8'hBB; we = 1; addr = 1; #10;
    data_in = 8'hCC; we = 1; addr = 2; #10;
    // Read back the data
    we = 0; addr = 0; #10;
    $display("Data at address 0: %h", data_out);
    addr = 1; #10;
    $display("Data at address 1: %h", data_out);
    addr = 2; #10;
    $display("Data at address 2: %h", data_out);
    $finish;
end
endmodule