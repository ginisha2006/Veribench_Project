fsm_1100_tb; 

parameter CLK_PERIOD = 10; 
reg clk; 
reg rst; 
reg bit_in; 
wire pattern_detected; 

initial 
begin 
    #CLK_PERIOD rst = 1; 
    #CLK_PERIOD rst = 0; 
    #20 bit_in = 0; 
    #10 bit_in = 1; 
    #10 bit_in = 0; 
    #10 bit_in = 1; 
    #10 bit_in = 0; 
    #10 bit_in = 1; 
    #20 $display("Pattern detected: %b", pattern_detected); 
    $monitor($time, "clk:%b rst:%b bit_in:%b pattern_detected:%b", clk, rst, bit_in, pattern_detected); 
end 

always 
#(CLK_PERIOD/2) clk = ~clk;