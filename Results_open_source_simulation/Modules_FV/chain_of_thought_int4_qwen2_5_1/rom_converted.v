module tb_rom_simple (
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
);
    wire [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data_out;

    rom_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
        .addr(addr),
        .data_out(data_out)
    );

    reg clk;
    always #5 clk = ~clk;

    assert (@(posedge clk) disable iff (!reset)
            addr inside {[0:(1<<ADDR_WIDTH)-1]});

    assert (@(posedge clk) disable iff (!reset)
            $stable(data_out));

endmodule