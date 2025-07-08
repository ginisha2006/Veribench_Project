ram_separate_io_tb; 

parameter CLK_PERIOD = 10; 
reg clk; 
reg reset; 
reg [7:0] addr; 
reg [7:0] data_in; 
wire [7:0] data_out; 

initial begin 
    $monitor($time, "clk:", clk, "reset:", reset, "addr:", addr, "data_in:", data_in, "data_out:", data_out); 
    reset = 1'b1; 
    #CLK_PERIOD reset = 1'b0; 
    #10000; 
    for (int i = 0; i < 16; i++) begin 
        addr = i; 
        data_in = i; 
        #CLK_PERIOD; 
    end 
    for (int i = 15; i >= 0; i--) begin 
        addr = i; 
        data_in = i; 
        #CLK_PERIOD; 
    end 
    $display("Test complete"); 
end 

always #(CLK_PERIOD/2) clk = ~clk;