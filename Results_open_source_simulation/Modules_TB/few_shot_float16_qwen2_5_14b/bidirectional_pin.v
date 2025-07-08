module tb_bidir_pin;
// Parameters
parameter WIDTH = 1;
// Inputs
reg dir;
reg [WIDTH-1:0] data_out;
inout [WIDTH-1:0] pin;
// Outputs
wire [WIDTH-1:0] data_in;
// Instantiate the Bidirectional Pin Module
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
    $monitor("%0d	%b	%b	%b	%b", $time, dir, data_out, pin, data_in);
    // Initialize signals
    dir = 0; data_out = 0; pin = 0; #10;
    // Test Case 1: Direction set to output with data_out = 0
    dir = 1; data_out = 0; pin = 0; #10;
    // Test Case 2: Direction set to output with data_out = 1
    dir = 1; data_out = 1; pin = 0; #10;
    // Test Case 3: Direction set to input with pin = 0
    dir = 0; data_out = 1; pin = 0; #10;
    // Test Case 4: Direction set to input with pin = 1
    dir = 0; data_out = 1; pin = 1; #10;
    // Test Case 5: Direction toggled between input and output
    dir = 1; data_out = 1; pin = 1; #10;
    dir = 0; data_out = 1; pin = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule