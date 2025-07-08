alu_4bit_tb; 

parameter CLOCK_PERIOD = 10; 

reg clk; 
reg [3:0] a; 
reg [3:0] b; 
wire [3:0] ALU_Result; 
wire Zero; 
wire Carry; 
wire Overflow; 

initial begin 
    #20 $monitor($time,"clk=a=%b,b=%b,ALU_Sel=%b,ALU_Result=%b,Zero=%b,Carry=%b,Overflow=%b",clk,a,b,3'b000,a,ALU_Result,Zero,Carry,Overflow); 
    clk = 0; 
    forever begin 
        #CLOCK_PERIOD clk = ~clk; 
    end 
end 

initial begin 
    #50 a = 4'b1111; 
    #50 b = 4'b1111; 
    #50 ALU_Sel = 3'b000; 
    #100 a = 4'b0000; 
    #100 b = 4'b0000; 
    #100 ALU_Sel = 3'b001; 
    #100 a = 4'b1111; 
    #100 b = 4'b0001; 
    #100 ALU_Sel = 3'b010; 
    #100 a = 4'b1111; 
    #100 b = 4'b1111; 
    #100 ALU_Sel = 3'b011; 
    #100 a = 4'b0000; 
    #100 b = 4'b0000; 
    #100 ALU_Sel = 3'b100; 
    #100 a = 4'b1111; 
    #100 b = 4'b0001; 
    #100 ALU_Sel = 3'b101; 
    #100 a = 4'b1111; 
    #100 ALU_Sel = 3'b110; 
    #100 a = 4'b1111; 
    #100 ALU_Sel = 3'b111; 
    #100 a = 4'b0000; 
    #100 ALU_Sel = 3'b111; 
end 

always @(posedge clk) begin 
    #1 a = a + 1; 
    #1 b = b + 1; 
end