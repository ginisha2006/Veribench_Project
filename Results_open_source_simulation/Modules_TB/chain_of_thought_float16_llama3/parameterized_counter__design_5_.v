module param_counter_tb;

parameter MAX_COUNT = 255;

reg clk;
reg rst;
wire [($clog2(MAX_COUNT+1)-1:0) count;

initial begin
    #10 clk = 0;
    forever #(50) clk = ~clk;
end

initial begin
    rst = 1;
    #100 rst = 0;
    #200 $display("Count: %h", count);
    #500 $finish;
end

param_counter uut (
   .clk(clk),
   .rst(rst),
   .count(count)
);

always @(posedge clk) begin
    $monitor($time, "Count: %h", count);
end

endmodule