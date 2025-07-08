module tb_param_adder;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Inputs
reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
// Outputs
wire [WIDTH-1:0] sum;
wire carry;
// Instantiate the Parameterized Adder
param_adder #(.WIDTH(WIDTH)) uut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);
initial begin
    // Display the header for the output
    $display("Time	a			b			sum			carry");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b			%b			%b			%b", $time, a, b, sum, carry);
    // Initialize signals
    a = 0; b = 0; #10;
    a = 0; b = 1; #10;
    a = 1; b = 0; #10;
    a = 1; b = 1; #10;
    a = {WIDTH{1'b0}} + 1; b = {WIDTH{1'b0}} + 1; #10;
    a = {WIDTH{1'b1}}; b = {WIDTH{1'b1}}; #10;
    a = {WIDTH{1'b1}} - 1; b = {WIDTH{1'b1}} - 1; #10;
    a = {WIDTH{1'b1}}; b = {WIDTH{1'b0}}; #10;
    // Finish the simulation
    $finish;
end
endmodule