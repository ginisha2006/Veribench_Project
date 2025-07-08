timescale 1ns / 100ps

module tb_fsm_1100;

parameter PERIOD = 10; // in ns

reg clk;
reg rst;
reg bit_in;

wire pattern_detected;

initial begin
    #(-PERIOD/2) clk = 1'b0;
    forever #(PERIOD) clk = ~clk;
end

initial begin
    #(-PERIOD/2) rst = 1'b1;
    #PERIOD rst = 1'b0;
end

initial begin
    bit_in = 1'b0;
    repeat(4) begin
        #PERIOD bit_in = ~bit_in;
    end
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b1;
    #PERIOD bit_in = 1'b0;
    #PERIOD bit_in = 1'b