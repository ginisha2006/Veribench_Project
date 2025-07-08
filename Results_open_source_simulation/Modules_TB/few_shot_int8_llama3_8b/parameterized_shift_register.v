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
    clk = 0; rst = 1; #20;
    rst = 0; #10;
    // Initialize data in
    data_in = 16'hAA; #10;
    // Test Case 1: Load with valid data
    load = 1; #10;
    load = 0; #10;
    // Test Case 2: No load, clock cycles
    for (int i = 0; i < 10; i++) begin
        #10 clk = ~clk;
    end
    // Test Case 3: Reset while loaded
    rst = 1; #10;
    rst = 0; #10;
    // Finish the simulation
    $finish;
end
always #5 clk = ~clk; // Generate clock
endmodule