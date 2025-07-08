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
bidir_pin uut (
    .dir(dir),
    .data_out(data_out),
    .pin(pin),
    .data_in(data_in)
);
initial begin
    // Display the header for the output
    $display("Time	dir	data_out	pin	data_in");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, dir, data_out, pin, data_in);
    // Test various scenarios
    dir = 0; data_out = 1; pin = 1; #10;
    dir = 1; data_out = 1; pin = 1; #10;
    dir = 1; data_out = 0; pin = 0; #10;
    dir = 0; data_out = 1; pin = 0; #10;
    dir = 1; data_out = 1; pin = 1'bz; #10;
    dir = 0; data_out = 1; pin = 1; #10;
    // Finish the simulation
    $finish;
end
endmodule