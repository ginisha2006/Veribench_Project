module tb_param_shift_reg;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Clock and reset signals
reg clk;
reg rst;
// Load signal
reg load;
// Data in
reg [WIDTH-1:0] data_in;
// Data out
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
    clk = 0; rst = 1; #20; rst = 0;
    // Initialize data in
    data_in = 16'hA2; #10;
    // Test case 1: Load with valid data
    load = 1; #10; load = 0; #10;
    // Test case 2: No load, clock cycles
    #100; #10;
    // Test case 3: Reset while loaded
    rst = 1; #10; rst = 0; #10;
    // Finish the simulation
    $finish;
end
always #5 clk = ~clk;  // Generate clock signal
endmodule