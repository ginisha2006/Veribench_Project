module tb_bidir_pin;
// Parameter
parameter WIDTH = 1;  
// Inputs
reg dir;
reg [WIDTH-1:0] data_out;
// Outputs
wire [WIDTH-1:0] data_in;
// Inout
wire [WIDTH-1:0] pin;
// Instantiate the Bidirectional Pin
bidir_pin #( .WIDTH(WIDTH) ) uut (
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
    // Test Case 1: Input direction - Output
    dir = 1'b1; data_out = 2'b01; #10;
    // Test Case 2: Input direction - Input
    dir = 1'b0; data_out = 2'b10; #10;
    // Test Case 3: High Impedance State
    dir = 1'bx; data_out = 2'b11; #10;
    // Finish the simulation
    $finish;
end
endmodule