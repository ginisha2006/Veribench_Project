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
        // Initialize clock
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        // Display the header for the output
        $display("Time	rst	bit_in	pattern_detected");
        // Monitor changes to inputs and outputs
        $monitor("%0d	%b	%b	%b", $time, rst, bit_in, pattern_detected);
        // Apply reset
        rst = 1; #10;
        rst = 0; #10;
        
        // Stimulus: Generate sequence to detect "1100" pattern
        bit_in = 0; #10;
        bit_in = 1; #10;
        bit_in = 1; #10;
        bit_in = 0; #10;
        bit_in = 0; #10;
        bit_in = 1; #10;
        bit_in = 1; #10;
        bit_in = 0; #10;
        bit_in = 0; #10;
        bit_in = 1; #10;
        bit_in = 1; #10;
        bit_in = 0; #10;
        bit_in = 0; #10;
        bit_in = 1; #10;
        bit_in = 1; #10;
        bit_in = 0; #10;
        
        // Finish the simulation
        $finish;
    end
endmodule