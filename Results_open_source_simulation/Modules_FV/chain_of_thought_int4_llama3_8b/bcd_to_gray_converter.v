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
    property p_valid_input;
       !($onehot(bcd)) |=>!($rose(gray));
    endproperty

    property p_invalid_input;
        ($onehot(bcd) && $rose(gray)) |=> $falsify;
    endproperty

    property p_output_range;
        [$signed'(bcd[BCD_WIDTH-1:0]) => $distinct0(gray[GRAY_WIDTH-1:0]);
    endproperty

    property p_edge_cases;
        @(posedge clk) disable iff (!clk);
        (bcd == 0) |=> (gray == 0);
        (bcd == 9) |=> (gray == 8'h7);
    endproperty

    assert property(p_valid_input);
    assert property(p_invalid_input);
    assert property(p_output_range);
    assert property(p_edge_cases);

endmodule