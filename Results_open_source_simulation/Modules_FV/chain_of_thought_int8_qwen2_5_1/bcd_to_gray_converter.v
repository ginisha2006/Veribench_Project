module tb_bcd_to_gray;
    logic [3:0] bcd;
    logic [3:0] gray;

    bcd_to_gray #(.BCD_WIDTH(4), .GRAY_WIDTH(4)) dut (
        .bcd(bcd),
        .gray(gray)
    );

    always begin
        #(5ns) clk = ~clk;
    end

    logic clk = 0;

    property p_valid_input;
        @(posedge clk)
        ($isunknown(bcd) |-> $isunknown(gray));
        (@(posedge clk) disable iff($isunknown(bcd))
         !($isunknown(gray)));
    endproperty
    assert property(p_valid_input);

    property p_output_behavior;
        @(posedge clk)
        (bcd == 4'b0000 |-> gray == 4'b0000);
        (bcd == 4'b0001 |-> gray == 4'b0001);
        (bcd == 4'b0010 |-> gray == 4'b0011);
        (bcd == 4'b0011 |-> gray == 4'b0010);
        (bcd == 4'b0100 |-> gray == 4'b0110);
        (bcd == 4'b0101 |-> gray == 4'b0111);
        (bcd == 4'b0110 |-> gray == 4'b0101);
        (bcd == 4'b0111 |-> gray == 4'b0100);
        (bcd == 4'b1000 |-> gray == 4'b1100);
        (bcd == 4'b1001 |-> gray == 4'b1101);
    endproperty
    assert property(p_output_behavior);

    property p_edge_cases;
        @(posedge clk)
        (bcd === 4'b1010 |-> gray !== 4'b1110);
        (bcd === 4'b1011 |-> gray !== 4'b1111);
        (bcd === 4'b1100 |-> gray !== 4'b1011);
        (bcd === 4'b1101 |-> gray !== 4'b1010);
        (bcd === 4'b1110 |-> gray !== 4'b1001);
        (bcd === 4'b1111 |-> gray !== 4'b1000);
    endproperty
    assert property(p_edge_cases);

endmodule