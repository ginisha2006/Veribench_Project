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

    // Functional correctness
    property read_correctness;
        @(posedge clk) disable iff (!reset)
            $onehot(addr[(ADDR_WIDTH-1):2]) |-> data_out == dut.mem[addr];
    endproperty
    assert property(read_correctness);

    // Edge case - address out of range
    property out_of_range;
        @(posedge clk) disable iff (!reset)
            !($isunknown(addr)) && !(addr < (1 << ADDR_WIDTH))
                |-> $isunknown(data_out);
    endproperty
    assert property(out_of_range);

    // Overflow/Underflow is not applicable as it's a ROM with fixed addresses

endmodule