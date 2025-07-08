module param_multiplier_tb;

parameter WIDTH = 4; // Set width for this testbench instance

reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
wire [2*WIDTH-1:0] product;

param_multiplier #(.WIDTH(WIDTH)) DUT (a, b, product);

initial begin
    $monitor($time, "a=%b, b=%b, product=%h", a, b, product);

    #100 a = 3'b001; b = 3'b010; // Test with small values
    #100 a = 8'h12; b = 8'h34; // Test with larger values
    #100 a = 8'haF; b = 8'h01; // Test with overflow condition
    #100 a = 8'h00; b = 8'h00; // Test with zero inputs
    #100 $finish;
end

initial begin
    #50 a <= 8'h01; b <= 8'h02; // Initialize inputs
end

always #10 a <= ~a; // Toggle 'a' signal
always #20 b <= ~b; // Toggle 'b' signal

endmodule