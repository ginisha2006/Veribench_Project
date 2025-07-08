module param_adder_tb;

parameter WIDTH = 4; // Change this value to test different widths

reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
wire [WIDTH-1:0] sum;
wire carry;

param_adder #(.WIDTH(WIDTH)) DUT (a, b, sum, carry);

initial begin
    #10; // Initialize signals
    a = 0;
    b = 0;
    #10;
    $monitor($time, "a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    
    // Test with small values
    a = 2'b01; b = 2'b01; #20;
    a = 2'b11; b = 2'b01; #20;
    a = 2'b11; b = 2'b11; #20;
    
    // Test with large values
    a = 4'd12; b = 4'd5; #20;
    a = 4'd15; b = 4'd7; #20;
    a = 4'd16; b = 4'd9; #20;
    
    // Test with overflow
    a = 4'd127; b = 4'd1; #20;
    a = 4'd128; b = 4'd1; #20;
    
    #100 $finish;
end

endmodule