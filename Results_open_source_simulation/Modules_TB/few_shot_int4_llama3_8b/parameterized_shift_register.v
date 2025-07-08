module tb_param_shift_reg;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Clock
reg clk;
// Reset
reg rst;
// Load
reg load;
// Data In
reg [WIDTH-1:0] data_in;
// Data Out
wire [WIDTH-1:0] data_out;
// Instantiate the Parameterized Shift Register
param_shift_reg #(.WIDTH(WIDTH)) uut (
   .clk(clk), 
   .rst(rst), 
   .load(load), 
   .data_in(data_in), 
   .data_out(data_out)
);
initial begin
    // Initialize clock and reset
    clk = 0; rst = 0; #20;
    clk = ~clk; #10;
    rst = 1; #10;
    rst = 0; #10;
    clk = ~clk; #10;
    // Test Case 1: No reset, no load
    data_in = 8'h12; #100;
    // Test Case 2: Reset, no load
    data_in = 8'h12; rst = 1; #10;
    data_in = 8'h12; rst = 0; #10;
    // Test Case 3: Load with new value
    data_in = 8'h34; load = 1; #10;
    load = 0; #10;
    // Test Case 4: Load with same value
    data_in = 8'h12; load = 1; #10;
    load = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule