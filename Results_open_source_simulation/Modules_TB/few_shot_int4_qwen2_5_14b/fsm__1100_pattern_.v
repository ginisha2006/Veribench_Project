module tb_fsm_1100;
// Inputs
reg clk;
reg rst;
reg bit_in;
// Outputs
wire pattern_detected;

// Instantiate the FSM module
fsm_1100 uut (
    .clk(clk),
    .rst(rst),
    .bit_in(bit_in),
    .pattern_detected(pattern_detected)
);

initial begin
    // Initialize inputs
    clk = 0;
    rst = 1;
    bit_in = 0;
    // Display the header for the output
    $display("Time	rst	bit_in	pattern_detected");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, rst, bit_in, pattern_detected);
    // Clock generation process
    forever #5 clk = ~clk;
end

initial begin
    // Reset active
    rst = 1; #10;
    rst = 0; #10;
    
    // Test sequence to detect "1100" pattern
    bit_in = 1; #20;
    bit_in = 1; #20;
    bit_in = 0; #20;
    bit_in = 0; #20;
    
    // Additional tests
    bit_in = 1; #20;
    bit_in = 0; #20;
    bit_in = 1; #20;
    bit_in = 1; #20;
    bit_in = 0; #20;
    bit_in = 0; #20;
    
    // Finish the simulation
    $finish;
end
endmodule