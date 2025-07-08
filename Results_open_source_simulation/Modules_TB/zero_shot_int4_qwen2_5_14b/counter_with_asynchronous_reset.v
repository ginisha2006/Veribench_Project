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
        clk <= 0; 
        reset <= 0; 
        ena <= 0;
        #10;
        reset <= 1;
        #10;
        reset <= 0;
        #10;
        ena <= 1;
        #50;
        ena <= 0;
        #30;
        ena <= 1;
        #40;
        $finish;
    end

    always #5 clk = ~clk;

    initial begin
        $monitor($time, " ns: clk=%b, reset=%b, ena=%b, result=%d", clk, reset, ena, result);
    end
endmodule