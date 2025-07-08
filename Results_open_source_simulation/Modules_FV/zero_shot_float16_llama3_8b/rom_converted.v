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
    // Property for overflow/underflow
    // Property for illegal transition
    // Assert properties
    always @(*) begin assert (@(posedge clk) disable iff (!clk) ($onehot(addr) |=> $rose(data_out))); end
    always @(*) begin assert (@(posedge clk) disable iff (!clk) ((addr >= (1 << ADDR_WIDTH) - 1) |-> ##1!data_out)); end
    assert property (p_ilegal_transition);

endmodule