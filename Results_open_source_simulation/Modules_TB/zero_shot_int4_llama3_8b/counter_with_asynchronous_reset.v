module tb_counter;

parameter PERIOD = 10; // in ns
reg clk;
reg reset;
reg ena;
wire [7:0] result;

counter dut (
	.clk(clk),
	.reset(reset),
	.result(result),
	.ena(ena)
);

initial begin
    #(-PERIOD/2) clk = 1'b0;
    repeat (100) #PERIOD clk = ~clk;
end

initial begin
    #10 reset = 1'b1;
    #50 reset = 1'b0;
    #50 ena = 1'b1;
    #200 ena = 1'b0;
    #500 $display("Result: %b", result);
    $stop;
end

initial begin
    $monitor($time, "clk=%b, reset=%b, ena=%b, result=%b", clk, reset, ena, result);
end

endmodule