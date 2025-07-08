module tb_fsm_1100;
// Clock and reset signals
reg clk;
reg rst;
// Input signal
reg bit_in;
// Output signal
wire pattern_detected;
// Instantiate the FSM
fsm_1100 uut (
   .clk(clk),
   .rst(rst),
   .bit_in(bit_in),
   .pattern_detected(pattern_detected)
);
initial begin
    // Initialize clock and reset
    clk = 0;
    rst = 1;
    #20;
    rst = 0;
    // Clock period
    repeat(100) begin
        clk = ~clk;
        #10;
    end
    // Test the FSM
    bit_in = 0; #10;
    bit_in = 1; #10;
    bit_in = 0; #10;
    bit_in = 1; #10;
    bit_in = 0; #10;
    // Check the output
    $display("Pattern detected: %b", pattern_detected);
    // Finish the simulation
    $finish;
end
endmodule