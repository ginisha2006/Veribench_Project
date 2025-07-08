module tb_ram_dual (
    input clk_read,
    input clk_write,
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    output reg [7:0] q
);
    
    wire [7:0] data_in;
    wire [5:0] addr_read;
    wire [5:0] addr_write;
    wire wr_en;

    // Instantiate the DUT
    ram_dual dut (
        .data(data),
        .read_addr(read_addr),
        .write_addr(write_addr),
        .we(we),
        .read_clock(clk_read),
        .write_clock(clk_write),
        .q(q)
    );

    // Clock generation
    always begin
        clk_read = 0; #5; clk_read = 1; #5;
    end
    
    always begin
        clk_write = 0; #2.5; clk_write = 1; #2.5;
    end

    // Functional correctness
    property prop_read_correctness;
        @(posedge clk_read) disable iff (!we)
            read_addr == write_addr |-> q === data;
    endproperty
    assert property(prop_read_correctness);

    // Write operation does not affect read address outside its window
    property prop_no_cross_write_effect;
        @(posedge clk_read) disable iff (!we)
            read_addr != write_addr |-> q !== data;
    endproperty
    assert property(prop_no_cross_write_effect);

    // Overflow/Underflow checks on addresses
    property prop_address_bounds;
        @(posedge clk_write) disable iff (!we)
            write_addr < 64 && write_addr >= 0;
    endproperty
    assert property(prop_address_bounds);

    // Ensure read address stays within bounds
    property prop_read_address_bounds;
        @(posedge clk_read)
            read_addr < 64 && read_addr >= 0;
    endproperty
    assert property(prop_read_address_bounds);

endmodule