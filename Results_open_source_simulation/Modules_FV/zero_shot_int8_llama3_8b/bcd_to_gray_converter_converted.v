module tb_bcd_to_gray;
    // Input and Output Signals
    logic [3:0] bcd_in;
    logic [3:0] gray_out;

    // DUT Instantiation
    bcd_to_gray dut (.bcd(bcd_in),.gray(gray_out));

    // Clock Generation
    always #10 clk = ~clk; // Non-inverting clock with 10 ns period

    // Property 1: Functional Correctness
    // Property 2: Overflow/Underflow Check
    // Property 3: Illegal Transitions
    // Assert Properties
    always @(*) begin assert (@(posedge clk) disable iff (!rst_n) ($onehot0(bcd_in) |=> $onehot0(gray_out))); end
    always @(*) begin assert (@(posedge clk) disable iff (!rst_n) ((bcd_in >= 9'hF) |-> gray_out == 4'b1000)); end
    always @(*) begin assert (@(posedge clk) disable iff (!rst_n) ((bcd_in!= bcd_in) |-> gray_out!== gray_out)); end

    // Reset Signal
    logic rst_n = 1'b1;

    // Clock Signal
    logic clk = 1'b0;

endmodule