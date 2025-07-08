module tb_param_divider;

parameter WIDTH = 8;

reg [WIDTH-1:0] dividend;
reg [WIDTH-1:0] divisor;
wire [WIDTH-1:0] quotient;
wire [WIDTH-1:0] remainder;

param_divider #(.WIDTH(WIDTH)) DUT (
   .dividend(dividend),
   .divisor(divisor),
   .quotient(quotient),
   .remainder(remainder)
);

initial begin
    #10; // delay for setup
    dividend = 16'd12; // initial value
    divisor = 16'd3;
    #20; // wait for clock cycle
    $display("Divide %d by %d:", dividend, divisor);
    #10;
    dividend = 16'd25; // new value
    divisor = 16'd5;
    #20; // wait for clock cycle
    $display("Divide %d by %d:", dividend, divisor);
    #100; // wait for some time
    $finish;
end

always #10 divclk; // dummy clock

assign divclk = 1'b1; #5; assign divclk = 1'b0; #5;

initial begin
    $monitor($time, "dividend=%b, divisor=%b, quotient=%b, remainder=%b", 
             dividend, divisor, quotient, remainder);
end

endmodule