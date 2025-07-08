module param_multiplier_tb;

parameter WIDTH = 4; // Set the width for this testbench instance

reg [WIDTH-1:0] a, b;
wire [2*WIDTH-1:0] product;

param_multiplier #(.WIDTH(WIDTH)) DUT (a, b, product);

initial begin
    a = 3'b101;
    b = 3'b110;
    $monitor($time, "a = %b, b = %b, product = %h", a, b, product);
    #100;
    a = 4'd12;
    b = 4'd15;
    $monitor($time, "a = %b, b = %b, product = %h", a, b, product);
    #100;
    a = 8'hFF;
    b = 8'h01;
    $monitor($time, "a = %b, b = %b, product = %h", a, b, product);
    #100;
    $finish;
end

always #10;

endmodule