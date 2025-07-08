module gray_count_tb();

reg clk, enable, reset;
wire [7:0] gray_count;

gray_count uut (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count(gray_count)
);

initial begin
    #10; // delay for setup
    reset = 1; // reset pulse
    #20; // hold reset low for some time
    reset = 0;
    
    #10; // wait for some time
    
    enable = 1; // enable pulse
    #50; // count for some time
    enable = 0;
    
    #100; // wait for some time
    
    $monitor ($time, "gray_count: %b", gray_count);
end

always #5 clk = ~clk; // clock generation

initial begin
    clk = 0; // initial clock state
    repeat(100) @(posedge clk); // run for 100 cycles
end

endmodule