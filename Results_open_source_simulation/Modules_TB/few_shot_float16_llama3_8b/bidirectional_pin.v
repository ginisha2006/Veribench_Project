module tb_bidir_pin;
// Parameter
parameter WIDTH = 1;  // Default width is 1 bit
// Input/Output
inout wire [WIDTH-1:0] pin;
// Direction
reg dir;
// Data Out
reg [WIDTH-1:0] data_out;
// Data In
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
    $display("Time	dir	pin	data_out	data_in");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, dir, pin, data_in);
    // Test Case 1: Set direction to 0 (output mode)
    dir = 0; data_out = 1; #10;
    // Test Case 2: Set direction to 1 (input mode)
    dir = 1; #10;
    // Test Case 3: Change direction from output to input
    dir = 0; data_out = 1; #10; dir = 1; #10;
    // Test Case 4: Change direction from input to output
    dir = 1; #10; dir = 0; data_out = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule