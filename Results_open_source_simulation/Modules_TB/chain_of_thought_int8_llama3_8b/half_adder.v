half_adder_tb; 

parameter CLOCK_PERIOD = 10; 

reg clk; 
reg [1:0] a_in; 
reg [1:0] b_in; 
wire [1:0] sum_out; 
wire carry_out; 

initial begin 
    #0 clk = 1'b0; 
    forever begin 
        #CLOCK_PERIOD clk = ~clk; 
    end 
end 

initial begin 
    #20 a_in = 2'b00; 
    #CLOCK_PERIOD a_in = 2'b01; 
    #CLOCK_PERIOD a_in = 2'b10; 
    #CLOCK_PERIOD a_in = 2'b11; 
    #100 $finish; 
end 

always @(posedge clk) begin 
    {a_in[1], a_in[0]} = a_in; 
    {b_in[1], b_in[0]} = b_in; 
end 

always @(posedge clk) begin 
    $monitor($time, "a_in=%b, b_in=%b, sum_out=%b, carry_out=%b", a_in, b_in, sum_out, carry_out); 
end 

half_adder uut ( 
   .a(a_in[1]), 
   .b(b_in[1]), 
   .sum(sum_out), 
   .carry(carry_out) 
);