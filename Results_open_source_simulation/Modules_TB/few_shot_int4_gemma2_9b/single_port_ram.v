module tb_single_port_ram;
// Clock
reg clk;
// Data Input
reg [7:0] data;
// Address Input
reg [5:0] addr;
// Write Enable
reg we;
// Output
wire [7:0] q;
// Instantiate the Single Port RAM
single_port_ram uut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
);
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    // Initialize address and write enable signals
    addr = 0;
    we = 0;
    // Write data to memory locations
    data = 8'hAA;
    #10 we = 1; addr = 0; #10 we = 0;
    data = 8'hBB;
    #10 we = 1; addr = 1; #10 we = 0;
    data = 8'hCC;
    #10 we = 1; addr = 2; #10 we = 0;
    // Read data from memory locations
    addr = 0; #10 $display("Data at address 0: %h", q);
    addr = 1; #10 $display("Data at address 1: %h", q);
    addr = 2; #10 $display("Data at address 2: %h", q);
    $finish;
end
endmodule