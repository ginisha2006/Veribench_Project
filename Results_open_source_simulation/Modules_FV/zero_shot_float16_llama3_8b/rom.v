module tb_rom_simple;
    // Input and output signals declaration
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] data_out;

    // DUT instantiation
    rom_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (
       .addr(addr),
       .data_out(data_out)
    );

    // Clock generation
    always #10 clk = ~clk; // Assuming 10ns period

    // Property for functional correctness
    property p_correct_behavior;
        @(posedge clk) disable iff (!clk) ($onehot(addr) |=> $rose(data_out));
    endproperty

    // Property for overflow/underflow
    property p_overflow_underflow;
        @(posedge clk) disable iff (!clk) ((addr >= (1 << ADDR_WIDTH) - 1) |-> ##1!data_out);
    endproperty

    // Property for illegal transition
    property p_illegal_transition;
        @(posedge clk) disable iff (!clk) ((addr == 0) |-> ##1!data_out);
    endproperty

    // Assert properties
    assert property (p_correct_behavior);
    assert property (p_overflow_underflow);
    assert property (p_ilegal_transition);

endmodule