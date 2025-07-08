module tb_bidir_pin;
// Parameter
parameter WIDTH = 1;  // Default width is 1 bit
// Inputs
reg dir;
reg [WIDTH-1:0] data_out;
// Outputs
wire [WIDTH-1:0] pin;
wire [WIDTH-1:0] data_in;
// Instantiate the Bidirectional Pin
bidir_pin #(.WIDTH(WIDTH)) uut (
   .pin(pin), 
   .dir(dir), 
   .data_out(data_out), 
   .data_in(data_in)
);
initial begin
    // Display the header for the output
    $display("Time	dir	data_out	pin	data_in");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, dir, data_out, pin);
    // Test Case 1: Input mode
    dir = 0; data_out = 1; #10;
    dir = 0; data_out = 0; #10;
    // Test Case 2: Output mode
    dir = 1; data_out = 1; #10;
    dir = 1; data_out = 0; #10;
    // Test Case 3: High-Z mode
    dir = 0; data_out = 1; #10;
    dir = 1; data_out = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule