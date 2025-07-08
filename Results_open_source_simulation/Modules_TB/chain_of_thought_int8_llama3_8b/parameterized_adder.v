module tb_param_adder;

parameter WIDTH = 8;

reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
wire [WIDTH-1:0] sum;
wire carry;

param_adder #(.WIDTH(WIDTH)) DUT (a, b, sum, carry);

initial begin
    // Initialize inputs
    a = 5'b1010_0001;
    b = 5'b0110_0011;

    // Run for 10 clock cycles
    repeat (10) @(posedge clock); // Assuming there is a clock signal named 'clock'

    // Observe the outputs
    $monitor($time, "Sum: %h, Carry: %b", sum, carry);
end

always #10 clock = ~clock; // Assuming there is a clock signal named 'clock'
endmodule