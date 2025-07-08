module tb_bcd_to_gray;
    localparam BCD_WIDTH = 4;
    localparam GRAY_WIDTH = 4;

    // DUT instantiation
    bcd_to_gray dut (
       .bcd(),
       .gray()
    );

    // Clock signal generation
    reg clk;
    always #10 clk = ~clk;

    // Property-based assertions
    always @(*) begin assert (!($onehot(bcd)) |=>!($rose(gray))); end
    always @(*) begin assert (($onehot(bcd) && $rose(gray)) |=> $falsify); end
    always @(*) begin assert ([$signed'(bcd[BCD_WIDTH-1:0]) => $distinct0(gray[GRAY_WIDTH-1:0])); end
    always @(*) begin assert (@(posedge clk) disable iff (!clk); end
        (bcd == 0) |=> (gray == 0);
        (bcd == 9) |=> (gray == 8'h7));

endmodule