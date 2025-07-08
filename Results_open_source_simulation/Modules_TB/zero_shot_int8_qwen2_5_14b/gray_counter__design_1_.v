module tb_gray_count;
    reg clk;
    reg enable;
    reg reset;
    wire [7:0] gray_count;

    gray_count uut (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .gray_count(gray_count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        enable = 0;
        #10;
        reset = 0;
        enable = 1;
        #10;
        enable = 0;
        #10;
        enable = 1;
        #40;
        $finish;
    end

    initial begin
        $monitor($time," %t Reset=%b Enable=%b Gray Count=%b", $time, reset, enable, gray_count);
    end
endmodule