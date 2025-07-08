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
    rst = 0;
    #10 rst = 1;
    #10 rst = 0;
    #1000 rst = 1;
    #10 rst = 0;
    #260; // Wait for more than one cycle of counting
    $finish;
end

always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, tb_param_counter);
end

initial begin
    $monitor($time, " ns: clk=%b, rst=%b, count=%d", clk, rst, count);
end

endmodule