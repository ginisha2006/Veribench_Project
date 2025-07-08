module tb_gray_count();
    parameter CLOCK_PERIOD = 10;

    logic clk;
    logic enable;
    logic reset;
    logic [7:0] gray_count_exp;

    gray_count dut (
       .clk(clk),
       .enable(enable),
       .reset(reset),
       .gray_count(gray_count_exp)
    );

    always @(*) begin assert (!reset -> ($rose(reset) | $fell(reset))); end
    always @(*) begin assert (enable == 1 -> (!$stable(enable))); end
    always @(*) begin assert (reset -> gray_count == 0); end
    always @(*) begin assert (enable &&!reset -> gray_count!= gray_count_exp); end
    always @(*) begin assert (always (posedge clk) disable iff (!reset) $stable(no_ones_below)); end
    always @(*) begin assert (always (posedge clk) disable iff (!reset) $stable(q_msb)); end
    always @(*) begin assert (enable &&!reset -> $rise(gray_count) == gray_count_exp); end

    always #CLOCK_PERIOD clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;
        enable = 0;
        repeat (5) @(posedge clk);
        reset = 0;
        enable = 1;
        repeat (20) @(posedge clk);
        enable = 0;
        repeat (5) @(posedge clk);
        reset = 1;
        enable = 0;
        repeat (5) @(posedge clk);
    end
endmodule