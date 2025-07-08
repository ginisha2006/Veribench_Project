module gray_count_tb();

reg clk;
reg enable;
reg reset;

wire [7:0] gray_count;

initial begin
    #10 clk = 0;
    forever #(5) clk = ~clk;
end

initial begin
    reset = 1;
    #20 reset = 0;
    #100 enable = 1;
    #200 enable = 0;
    #500 $finish;
end

gray_count gray_count_dut (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count(gray_count)
);

$monitor($time, "Reset: %b, Enable: %b, Gray Count: %h", reset, enable, gray_count);

endmodule