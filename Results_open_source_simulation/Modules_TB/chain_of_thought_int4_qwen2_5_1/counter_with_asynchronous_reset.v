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
        forever #5 clk = ~clk;
    end

    initial begin
        reset <= 0; ena <= 0;
        #10;
        reset <= 1; ena <= 0;
        #10;
        reset <= 0; ena <= 1;
        #20;
        ena <= 0;
        #10;
        ena <= 1;
        #30;
        reset <= 1;
        #10;
        $finish;
    end

    always @(posedge clk) begin
        if (!reset && ena) $monitor($time, " %d: reset=%b ena=%b result=%d", $time, reset, ena, result);
    end
endmodule