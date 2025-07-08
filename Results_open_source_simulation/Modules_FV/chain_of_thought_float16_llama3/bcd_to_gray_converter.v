module tb_bcd_to_gray;
    parameter BCD_WIDTH = 4;
    parameter GRAY_WIDTH = 4;

    logic [BCD_WIDTH-1:0] bcd;
    logic [GRAY_WIDTH-1:0] gray;

    bcd_to_gray dut (
       .bcd(bcd),
       .gray(gray)
    );

    always begin
        #10 clk = ~clk;
    end

    property p_correct_conversion;
        @(posedge clk) ($rose(clk) |=> $onehot(gray));
    endproperty

    property p_invalid_input;
        @(posedge clk) ($fell(clk) |=>!($onehot(bcd)));
    endproperty

    property p_overflow;
        @(posedge clk) ($rose(clk) |=> $onehot(gray[GRAY_WIDTH-1]));
    endproperty

    assert property (p_correct_conversion);
    assert property (p_invalid_input);
    assert property (p_overflow);

    property p_edge_cases;
        @(posedge clk) ($rose(clk) |=> (bcd == 0) |-> gray == 0);
        @(posedge clk) ($rose(clk) |=> (bcd == 9) |-> gray == 7);
    endproperty

    assert property (p_edge_cases);

    property p_underflow;
        @(posedge clk) ($rose(clk) |=>!($onehot(gray[0])));
    endproperty

    assert property (p_underflow);

    property p_illegal_transition;
        @(posedge clk) ($rose(clk) |=> ((bcd == 8) & (gray!= 6)) |-> false);
    endproperty

    assert property (p_illegal_transition);

    logic clk = 0;

endmodule