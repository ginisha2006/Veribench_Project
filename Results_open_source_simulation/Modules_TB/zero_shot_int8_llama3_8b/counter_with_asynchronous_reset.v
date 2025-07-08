module tb_counter;

reg clk;
reg reset;
reg ena;
wire [7:0] result;

counter uut (
   .clk(clk),
   .reset(reset),
   .result(result),
   .ena(ena)
);

initial begin
    #100; // wait for 100 time units
    reset = 1; // asynchronous reset
    #10; // wait for 10 time units
    reset = 0; // release reset
    #50; // wait for 50 time units
    ena = 1; // enable counter
    #100; // wait for 100 time units
    ena = 0; // disable counter
    #100; // wait for 100 time units
    reset = 1; // asynchronous reset again
    #10; // wait for 10 time units
    reset = 0; // release reset
    #100; // wait for 100 time units
    $display("Final result: %h", result);
    $finish;
end

always #5 clk = ~clk; // clock generation

initial begin
    clk = 0;
    forever #10 clk = ~clk;
end

$monitor($time, "clk=%b, reset=%b, ena=%b, result=%h", clk, reset, ena, result);

endmodule