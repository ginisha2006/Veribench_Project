module tb_rom_simple();
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;

    wire [DATA_WIDTH-1:0] data_out;
    reg [ADDR_WIDTH-1:0] addr;
    reg clk;

    rom_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
        .addr(addr),
        .data_out(data_out)
    );

    always #5 clk =~clk;

    assert (@(posedge clk) disable iff (!reset)
            addr < (1 << ADDR_WIDTH) |-> ##1 data_out !== 'x);

    assert (@(posedge clk) disable iff (!reset)
            addr >= (1 << ADDR_WIDTH) |=> data_out === 'x);

endmodule