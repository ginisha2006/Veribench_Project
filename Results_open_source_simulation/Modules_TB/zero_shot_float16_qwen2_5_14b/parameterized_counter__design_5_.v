module tb_param_counter;

reg clk;
reg rst;
wire [7:0] count; // Assuming MAX_COUNT is 255, log2(256) = 8 bits

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
    $dumpfile("tb_param_counter.vcd");
    $dumpvars(0, tb_param_counter);
    
    #100 $finish;
end

initial begin
    $monitor($time," ns: clk=%b, rst=%b, count=%d", clk, rst, count);
end

endmodule