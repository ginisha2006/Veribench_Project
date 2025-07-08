module tb_bcd_to_gray;
    // Input and output signals declaration
    logic [3:0] bcd_in;
    logic [3:0] gray_out;

    // Instantiate the DUT
    bcd_to_gray dut (
       .bcd(bcd_in),
       .gray(gray_out)
    );

    // Clock signal generation
    always #10 clk = ~clk; // 10 ns period

    // Property for functional correctness
    // Property for overflow/underflow detection
    // Property for illegal transition
    // Assert properties
    always @(*) begin assert (@(posedge clk) ($onehotb(bcd_in) && $onehotb(gray_out))); end
    always @(*) begin assert (@(posedge clk) ((bcd_in >= 9'd1000) | (bcd_in < 9'd0000)) =>!($onehotb(gray_out))); end
    always @(*) begin assert (@(posedge clk) ((bcd_in!= bcd_in) => $onehotb(gray_out))); end

endmodule