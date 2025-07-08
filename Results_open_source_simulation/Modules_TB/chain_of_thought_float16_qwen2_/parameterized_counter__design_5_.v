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
        #265 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        $dumpfile("param_counter.vcd");
        $dumpvars(0, tb_param_counter);
    end

    initial begin
        #10 $monitor($time," ns: clk=%b, rst=%b, count=%d", clk, rst, count);
        #265 $finish;
    end
endmodule