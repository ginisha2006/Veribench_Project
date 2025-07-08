module tb_counter;
    reg clk;
    reg reset;
    reg ena;
    wire [7:0] result;

    counter uut (
        .clk(clk),
        .reset(reset),
        .result(result),
        .ena(ena)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock generation
    end

    initial begin
        reset = 1;
        ena = 0;
        #10;
        reset = 0;
        ena = 1;
        #40;
        ena = 0;
        #10;
        ena = 1;
        #30;
        ena = 0;
        #10;
        ena = 1;
        #60;
        $finish;
    end

    initial begin
        $monitor($time," ns: clk=%b, reset=%b, ena=%b, result=%d", clk, reset, ena, result);
    end
endmodule