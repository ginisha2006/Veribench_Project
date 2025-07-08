module gray_count_tb();

reg clk;
reg enable;
reg reset;

wire [7:0] gray_count;

initial begin
    #100 clk = 1'b0;
    #50 clk = 1'bx;
    #50 clk = 1'1;
    #500 reset = 1'b1;
    #100 reset = 1'b0;
    #100 enable = 1'b1;
    #10000 $finish;
end

always #5 clk = ~clk;

initial begin
    $monitor($time, "clk:", clk, "reset:", reset, "enable:", enable, "gray_count:", gray_count);
end

endmodule