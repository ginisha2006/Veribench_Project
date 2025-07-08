digital_filter_tb; 

parameter DATA_WIDTH = 16; 
parameter COEFF_WIDTH = 16; 
parameter NUM_TAPS = 32; 

reg clk; 
reg rst; 
wire [DATA_WIDTH-1:0] data_in; 
wire [DATA_WIDTH-1:0] data_out; 
reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0]; 

initial begin 
    #10; 
    rst = 1'b1; 
    repeat (100) begin 
        #5; 
        rst = 1'b0; 
        #5; 
        rst = 1'b1; 
    end 
end 

always #(posedge clk) begin 
    data_in <= $urandom_range(2**DATA_WIDTH - 1, 0); 
end 

always #(negedge clk) begin 
    coeff[0] <= $urandom_range(2**COEFF_WIDTH - 1, 0); 
    for (int i = 1; i < NUM_TAPS; i++) begin 
        coeff[i] <= coeff[i-1]; 
    end 
end 

initial begin 
    clk = 1'b0; 
    forever #(20) clk = ~clk; 
end 

$monitor($time, "rst=%b, data_in=%h, data_out=%h", rst, data_in, data_out);