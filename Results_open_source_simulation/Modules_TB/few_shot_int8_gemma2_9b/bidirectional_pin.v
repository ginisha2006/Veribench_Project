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
    // Test Case 1: Read mode
    dir = 0; data_out = 3'b101; #10;
    // Test Case 2: Write mode
    dir = 1; data_out = 3'b010; #10;
    // Test Case 3: Toggle direction
    dir = ~dir; data_out = 3'b111; #10;
    // Finish the simulation
    $finish;
end
endmodule