module tb_param_counter;

parameter MAX_COUNT = 255;
reg clk;
reg rst;
wire [($clog2(MAX_COUNT+1)-1:0)] count;

param_counter uut (
   .clk(clk),
   .rst(rst),
   .count(count)
);

initial begin
    #10; // delay for setup
    rst = 1; // reset
    #20; // hold reset for some time
    rst = 0; // release reset
    #100; // let counter run for some time
    $monitor ($time, "Count: %d", count); // observe count value
    #100; // let counter run for some more time
    rst = 1; // reset again
    #20; // hold reset for some time
    rst = 0; // release reset
    #100; // let counter run for some time
    $monitor ($time, "Count: %d", count); // observe count value
    #100; // let counter run for some more time
    $finish; // stop simulation after some time
end

always #5 clk = ~clk; // generate clock signal

endmodule