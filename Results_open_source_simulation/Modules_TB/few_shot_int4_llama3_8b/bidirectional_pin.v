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
    $monitor("%0d	%b	%b	%b", $time, dir, data_out, pin, data_in);
    // Test Case 1: Data Out enabled
    dir = 1; data_out = 1; #10;
    // Test Case 2: Data In enabled
    dir = 0; data_out = 1; #10;
    // Test Case 3: Data Out disabled
    dir = 1; data_out = 0; #10;
    // Test Case 4: Data In disabled
    dir = 0; data_out = 0; #10;
    // Test Case 5: Toggle direction
    dir = ~dir; #10;
    // Finish the simulation
    $finish;
end
endmodule