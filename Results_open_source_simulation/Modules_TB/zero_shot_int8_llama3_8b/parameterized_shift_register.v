module shift_reg_tb;

parameter WIDTH = 8;

reg clk;
reg rst;
reg load;
wire [WIDTH-1:0] data_in;
wire [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) DUT (
   .clk(clk),
   .rst(rst),
   .load(load),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    $display("Starting testbench...");
    
    // Initialize signals
    clk = 0;
    rst = 1;
    load = 0;
    data_in = 0;
    
    #100; // Wait for 100 clock cycles
    
    // Reset the register
    rst = 0;
    #10;
    
    // Load some data
    load = 1;
    data_in = 4'hA;
    #10;
    load = 0;
    
    // Check the output
    $display("Expected output: %h", 4'hA);
    $display("Actual output:   %h", data_out);
    
    // Test with different inputs
    for (int i = 0; i < 2**WIDTH; i++) begin
        data_in = i;
        load = 1;
        #10;
        load = 0;
        
        // Check the output
        $display("Input: %h", i);
        $display("Expected output: %h", i);
        $display("Actual output:   %h", data_out);
    end
    
    // Test reset again
    rst = 1;
    #10;
    rst = 0;
    
    #100; // Wait for 100 clock cycles
    
    $display("Testbench complete.");
end

always #5 clk = ~clk; // Clock generation

endmodule