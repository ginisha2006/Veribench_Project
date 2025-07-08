module tb_bidir_pin;
// Parameters
parameter WIDTH = 1;
// Inputs
reg dir;
reg [WIDTH-1:0] data_out;
// Outputs
wire [WIDTH-1:0] data_in;
// Bidirectional Signal
inout wire [WIDTH-1:0] pin;
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
    dir = 0; data_out = 0; #10;
    // Test Case 1: dir low, pin should be high-Z
    dir = 0; data_out = 1; #10;
    // Test Case 2: dir high, pin should follow data_out
    dir = 1; data_out = 1; #10;
    dir = 1; data_out = 0; #10;
    // Force pin to 1 when dir is low
    force pin = 1'b1; dir = 0; data_out = 0; #10;
    // Release pin
    release pin; dir = 0; data_out = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule