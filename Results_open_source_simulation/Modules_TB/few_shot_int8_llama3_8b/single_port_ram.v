module tb_single_port_ram;
// Inputs
reg [7:0] data;
reg [5:0] addr;
reg we;
reg clk;
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
    // Initialize the clock
    clk = 0; #10; forever clk = ~clk; #10;
    // Initialize the address register
    addr = 0; #10;
    // Monitor changes to inputs and outputs
    $monitor($time, " addr=%b, we=%b, data=%b, q=%b", addr, we, data, q);
    // Test Case 1: Write and read data at different addresses
    addr = 0; data = 16'h1234; we = 1; #20; addr = 1; data = 16'h5678; we = 1; #20; addr = 0; #10;
    addr = 1; #10;
    // Test Case 2: Read un-written data
    addr = 2; #10;
    // Test Case 3: Write and read data at same address
    addr = 0; data = 16'h9ABC; we = 1; #20; addr = 0; #10;
    addr = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule