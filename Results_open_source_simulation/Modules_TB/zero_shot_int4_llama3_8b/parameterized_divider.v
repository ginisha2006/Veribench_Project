module tb_param_divider;

parameter WIDTH = 8;
reg [WIDTH-1:0] dividend;
reg [WIDTH-1:0] divisor;
wire [WIDTH-1:0] quotient;
wire [WIDTH-1:0] remainder;

param_divider #(.WIDTH(WIDTH)) uut (
   .dividend(dividend),
   .divisor(divisor),
   .quotient(quotient),
   .remainder(remainder)
);

initial begin
    // Initialize inputs
    dividend = 16'd12;
    divisor = 8'd3;

    // Run the divider for different combinations of inputs
    #100; // wait for some time before starting the simulation
    $monitor($time, "Dividend: %d, Divisor: %d, Quotient: %d, Remainder: %d", dividend, divisor, quotient, remainder);
    #50; // wait for some time between each iteration
    dividend = 16'd15;
    divisor = 8'd5;
    #50;
    dividend = 16'd20;
    divisor = 8'd4;
    #50;
    dividend = 16'd24;
    divisor = 8'd2;
    #50;
    dividend = 16'd25;
    divisor = 8'd1;
    #50;
    dividend = 16'd30;
    divisor = 8'd3;
    #50;
    dividend = 16'd31;
    divisor = 8'd7;
    #50;
    dividend = 16'd32;
    divisor = 8'd8;
    #50;
    $finish; // end the simulation after all iterations
end

endmodule