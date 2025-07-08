fsm_1100_tb; 

reg clk; 
reg rst; 
reg bit_in; 
wire pattern_detected; 

initial begin 
    #10 rst = 1; 
    #20 rst = 0; 
    #100 $monitor($time, "State: %b, Bit_In: %b, Pattern_Detected: %b", state, bit_in, pattern_detected); 
    repeat(4) begin 
        #5 bit_in = 1; 
        #5 bit_in = 0; 
    end 
    #100 $finish; 
end 

always #(10) clk = ~clk;