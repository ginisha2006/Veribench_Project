module tb_counter();

reg clk;
reg reset;
reg ena;
wire [7:0] result;

counter dut (
   .clk(clk),
   .reset(reset),
   .ena(ena),
   .result(result)
);

initial begin
    #10; // delay for setup
    reset = 1; // asynchronous reset
    #5; // hold reset high for 5 clock cycles
    reset = 0;
    #10; // wait for reset to propagate
    ena = 1; // enable counter
    #100; // count for 100 clock cycles
    ena = 0; // disable counter
    #100; // wait for counter to stop counting
    $display("Final result: %h", result);
    $monitor($time, " clk=%b, reset=%b, ena=%b, result=%h");
end

always #10 clk = ~clk; // generate clock signal

endmodule