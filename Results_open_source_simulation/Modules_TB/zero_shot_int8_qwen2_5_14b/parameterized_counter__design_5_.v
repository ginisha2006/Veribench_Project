module tb_param_counter;

reg clk;
reg rst;
wire [7:0] count; // Assuming MAX_COUNT is 255, log2(256) = 8 bits

param_counter #(.MAX_COUNT(255)) uut (
    .clk(clk),
    .rst(rst),
    .count(count)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 1;
    #10 rst = 0;
    
    for(int i=0; i<300; i=i+1) begin
        #10;
        if(i == 50 || i == 150 || i == 250) 
            rst = 1;
        #10;
        rst = 0;
    end
    
    $stop;
end

initial begin
    $monitor($time," ns: clk=%b, rst=%b, count=%d", clk, rst, count);
end

endmodule