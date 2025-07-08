module tb_param_counter;

reg clk;
reg rst;
wire [7:0] count;

param_counter #(.MAX_COUNT(255)) uut (
    .clk(clk),
    .rst(rst),
    .count(count)
);

initial begin
    clk = 0;
    rst = 1;
    #10 rst = 0;
end

always #5 clk = ~clk;

initial begin
    // Monitor count value
    $monitor("Time %d ns: clk=%b, rst=%b, count=%d", $time, clk, rst, count);
    
    // Test reset condition
    rst = 1; @(negedge clk); rst = 0;
    
    // Count up to max_count - 1
    repeat(254) @(posedge clk);
    
    // Check overflow from max_count-1 to 0
    @(posedge clk);
    
    // Continue counting for some cycles after overflow
    repeat(10) @(posedge clk);
    
    // Re-test reset condition
    rst = 1; @(negedge clk); rst = 0;
    
    // Finish simulation
    $finish;
end

endmodule