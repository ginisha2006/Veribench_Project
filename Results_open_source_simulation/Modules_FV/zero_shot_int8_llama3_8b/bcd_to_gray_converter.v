module tb_bcd_to_gray;
    // Input and Output Signals
    logic [3:0] bcd_in;
    logic [3:0] gray_out;

    // DUT Instantiation
    bcd_to_gray dut (.bcd(bcd_in),.gray(gray_out));

    // Clock Generation
    always #10 clk = ~clk; // Non-inverting clock with 10 ns period

    // Property 1: Functional Correctness
    property p_func_correct;
        @(posedge clk) disable iff (!rst_n) ($onehot0(bcd_in) |=> $onehot0(gray_out));
    endproperty

    // Property 2: Overflow/Underflow Check
    property p_overflow_underflow;
        @(posedge clk) disable iff (!rst_n) ((bcd_in >= 9'hF) |-> gray_out == 4'b1000);
    endproperty

    // Property 3: Illegal Transitions
    property p_illegal_transition;
        @(posedge clk) disable iff (!rst_n) ((bcd_in!= bcd_in) |-> gray_out!== gray_out);
    endproperty

    // Assert Properties
    assert property (p_func_correct);
    assert property (p_overflow_underflow);
    assert property (p_illegal_transition);

    // Reset Signal
    logic rst_n = 1'b1;

    // Clock Signal
    logic clk = 1'b0;

endmodule