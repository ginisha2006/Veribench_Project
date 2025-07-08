module param_counter #(parameter MAX_COUNT = 255)(clk, rst, count); 

reg [7:0] count_reg; 

always @(posedge clk) begin 
    if (rst) count_reg <= 8'h0; 
    else count_reg <= count_reg + 1; 
end 

assign count = count_reg; 

endmodule