module tb_gray_count;

parameter PERIOD = 10; // Period of the clock

reg clk;

reg reset;

reg enable;

wire [7:0] gray_count;

gray_count gray_count_inst (.clk(clk),.reset(reset),.enable(enable),.gray_count(gray_count));

initial begin

    #PERIOD * 2; // Wait for two cycles before asserting reset

    reset = 1;

    #PERIOD;

    reset = 0;

    #PERIOD * 5; // Wait for five cycles before enabling the counter

    enable = 1;

    repeat(100) begin

        #PERIOD;

    end

    #PERIOD * 5; // Wait for five cycles after disabling the counter

    enable = 0;

    forever #PERIOD clk = ~clk; // Generate clock signal

end

endmodule