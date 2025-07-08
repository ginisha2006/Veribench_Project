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
    // Clock generation
    forever #5 clk = ~clk;
end

initial begin
    // Reset pulse
    #10 rst = 0;
    // Apply different sequences to detect '1100' pattern
    #20 bit_in = 0; #10;
    #30 bit_in = 1; #10;
    #40 bit_in = 1; #10;
    #50 bit_in = 0; #10;
    #60 bit_in = 0; #10;
    #70 bit_in = 1; #10;
    #80 bit_in = 1; #10;
    #90 bit_in = 0; #10;
    #100 bit_in = 1; #10;
    #110 bit_in = 0; #10;
    #120 bit_in = 0; #10;
    #130 bit_in = 1; #10;
    #140 bit_in = 1; #10;
    #150 bit_in = 0; #10;
    #160 bit_in = 0; #10;
    #170 bit_in = 1; #10;
    #180 bit_in = 1; #10;
    #190 bit_in = 0; #10;
    #200 bit_in = 1; #10;
    #210 bit_in = 0; #10;
    #220 bit_in = 0; #10;
    #230 bit_in = 1; #10;
    #240 bit_in = 1; #10;
    #250 bit_in = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule