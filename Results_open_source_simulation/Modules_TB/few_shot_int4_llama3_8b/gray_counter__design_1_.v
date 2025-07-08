module tb_gray_count;
// Clock and Reset
reg clk;
reg rst;
reg en;
// Outputs
wire [7:0] gray_count;
// Instantiate the Gray Counter
gray_count uut (
   .clk(clk),
   .enable(en),
   .reset(rst),
   .gray_count(gray_count)
);
initial begin
    // Initialize clock and reset signals
    clk = 0;
    rst = 1;
    en = 0;
    #20;
    rst = 0;
    en = 1;
    // Display the header for the output
    $display("Time	gray_count");
    // Monitor changes to outputs
    $monitor("%0t	%b", $time, gray_count);
    // Test the counter
    forever begin
        #10 clk = ~clk;
    end
end
endmodule