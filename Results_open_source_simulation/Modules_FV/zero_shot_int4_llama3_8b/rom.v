module tb_rom_simple;
    // Input and output signals declaration
    logic [7:0] clk;
    logic [7:0] rst_n;
    logic [7:0] addr;
    logic [7:0] data_in;
    logic [7:0] data_out;

    // DUT instantiation
    rom_simple #(
       .DATA_WIDTH(8),
       .ADDR_WIDTH(8)
    ) dut (
       .addr(addr),
       .data_out(data_out)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Property for functional correctness
    property p_read_correct;
        @(posedge clk) disable iff (!rst_n) ($rose(addr) |=> data_out == dut.mem[addr]);
    endproperty

    // Property for overflow/underflow
    property p_addr_range;
        @(posedge clk) disable iff (!rst_n) ((addr >= 0 && addr < (1 << ADDR_WIDTH)) |=> data_out!= 'x);
    endproperty

    // Property for reset behavior
    property p_reset;
        @(posedge clk) disable iff (rst_n) (data_out == 0);
    endproperty

    // Property for read operation
    property p_read;
        @(posedge clk) disable iff (!rst_n) (addr!= 0 |=> data_out == dut.mem[addr]);
    endproperty

    // Assert properties
    assert property (p_read_correct);
    assert property (p_addr_range);
    assert property (p_reset);
    assert property (p_read);

endmodule