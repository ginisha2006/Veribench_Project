module tb_gray_count;
    reg clk;
    reg enable;
    reg reset;
    wire [7:0] gray_count;

    gray_count uut (
        .clk(clk),
        .enable(enable),
        .reset(reset),
        .gray_count(gray_count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        enable = 0;
        #10;
        reset = 0;
        enable = 1;
        #10;
        
        // Test case 1: Reset condition
        reset = 1;
        #10;
        reset = 0;
        
        // Test case 2: Normal counting
        for(int i=0; i<256; i=i+1) begin
            #10;
        end
        
        // Test case 3: Disable counting
        enable = 0;
        #10;
        enable = 1;
        
        // Test case 4: Edge case - max count
        for(int i=0; i<256; i=i+1) begin
            #10;
        end
        
        $stop;
    end
    
    always @(posedge clk) begin
        $monitor("Time %0t: gray_count=%b", $time, gray_count);
    end
endmodule