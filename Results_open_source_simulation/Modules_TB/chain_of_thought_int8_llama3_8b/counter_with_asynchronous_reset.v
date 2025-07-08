module tb_counter();

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
    #100; // initial delay
    reset = 1; // asynchronous reset
    #10; // hold reset for 10 clock cycles
    reset = 0;
    #100; // wait for 100 clock cycles
    ena = 1; // enable counter
    #100; // count for 100 clock cycles
    ena = 0; // disable counter
    #100; // wait for 100 clock cycles
    $display("Final result: %h", result);
    $finish;
end

always #5 clk = ~clk; // generate clock signal

$monitor($time, "clk=%b, reset=%b, ena=%b, result=%h", clk, reset, ena, result);

endmodule