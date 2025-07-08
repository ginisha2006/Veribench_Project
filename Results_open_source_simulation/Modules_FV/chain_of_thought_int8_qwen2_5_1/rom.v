module tb_rom_simple;
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;

    wire [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data_out;

    reg clk;
    
    always #5 clk = ~clk;

    rom_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
        .addr(addr),
        .data_out(data_out)
    );

    property read_address_in_range;
        @(posedge clk) disable iff (!reset)
            addr < (1 << ADDR_WIDTH) |-> data_out !== 'x;
    endproperty

    assert property(read_address_in_range);

    property address_overflow;
        @(posedge clk) disable iff (!reset)
            addr >= (1 << ADDR_WIDTH) |=> data_out === 'x;
    endproperty

    assert property(address_overflow);

    property data_stability;
        @(posedge clk) disable iff (!reset)
            ##[0:$] (addr !== ?[*]) |-> ##1 data_out == data_out;
    endproperty

    assert property(data_stability);

endmodule