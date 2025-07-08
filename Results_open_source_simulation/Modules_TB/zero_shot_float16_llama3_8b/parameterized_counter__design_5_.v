module param_counter_tb;

parameter MAX_COUNT = 255;

reg clk;
reg rst;
wire [($clog2(MAX_COUNT+1)-1:0) count;

initial begin
    #10 clk = 0;
    forever #(5) clk = ~clk;
end

initial begin
    rst = 1;
    #20 rst = 0;
    #100 $display("Initial count value: %h", count);
    #100 $display("Counting up...");
    repeat(50) @(posedge clk);
    #100 $display("Count reached maximum value: %h", count);
    #100 $display("Count reset...");
    #20 rst = 1;
    #100 $display("Final count value: %h", count);
end

always @(posedge clk) begin
    $monitor($time, "count=%b", count);
end

param_counter uut (
   .clk(clk),
   .rst(rst),
   .count(count)
);

endmodule