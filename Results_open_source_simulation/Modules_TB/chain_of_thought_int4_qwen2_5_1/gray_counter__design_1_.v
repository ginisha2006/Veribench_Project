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
        @(negedge clk);
        @(negedge clk);
        reset = 0;
        enable = 1;
        for(int i=0; i<256; i=i+1) begin
            @(negedge clk);
        end
        enable = 0;
        @(negedge clk);
        @(negedge clk);
        $finish;
    end

    initial begin
        $monitor($time," ns: clk=%b, enable=%b, reset=%b, gray_count=%b", clk, enable, reset, gray_count);
    end
endmodule