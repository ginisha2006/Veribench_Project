module gray_count_tb();

reg clk;
reg enable;
reg reset;

wire [7:0] gray_count;

initial begin
    #100 clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1;
    #200 reset = 0;
    #100 enable = 1;
    #400 enable = 0;
    #500 $finish;
end

initial begin
    $monitor($time, "Reset", reset);
    $monitor($time, "Enable", enable);
    $monitor($time, "Gray Count:", gray_count);
end

gray_count uut (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count(gray_count)
);

endmodule