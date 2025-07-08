bidir_pin_tb; 

parameter WIDTH = 1; 

reg [WIDTH-1:0] data_out; 
reg dir; 
wire [WIDTH-1:0] pin; 
wire [WIDTH-1:0] data_in; 

initial begin 
    dir = 0; 
    data_out = 8'h12; 
    #10; 
    dir = 1; 
    #10; 
    dir = 0; 
    #10; 
    dir = 1; 
    #10; 
    dir = 0; 
    #20; 
    $display("Test completed"); 
    $finish; 
end 

always @(posedge dir) 
    $monitor($time, "dir=%b, pin=%h", dir, pin); 

always @(posedge dir) 
    $monitor($time, "data_in=%h", data_in);