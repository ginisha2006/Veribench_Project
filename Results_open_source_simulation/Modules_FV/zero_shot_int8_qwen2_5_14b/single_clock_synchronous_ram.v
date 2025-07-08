module tb_ram_infer (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input clk,
    output reg [7:0] q
);
    
    wire clk_wire;

    // Clock generation
    always #10 clk_wire = ~clk_wire;

    // DUT instantiation
    ram_infer dut (
        .data(data),
        .read_addr(read_addr),
        .write_addr(write_addr),
        .we(we),
        .clk(clk_wire),
        .q(q)
    );

    // Functional correctness
    property p_read_write_correctness;
        @(posedge clk_wire) disable iff (!we)
            ($past(we)) |-> q == data;
    endproperty
    assert property(p_read_write_correctness);

    // Edge case - simultaneous read/write on same address
    property p_same_address_rw;
        @(posedge clk_wire) disable iff (!we)
            (write_addr == read_addr) |-> $stable(q);
    endproperty
    assert property(p_same_address_rw);

    // Over/Underflow check is not applicable as addresses are bounded within [0:63]

    // Illegal transition - write enable should not change state without clock edge
    property p_we_stable_between_clock_edges;
        @(negedge clk_wire) disable iff (!we)
            !($rose(we));
    endproperty
    assert property(p_we_stable_between_clock_edges);

    // Ensure read address does not cause out-of-bounds access
    property p_read_addr_bounds;
        @(posedge clk_wire) read_addr < 64;
    endproperty
    assert property(p_read_addr_bounds);

    // Ensure write address does not cause out-of-bounds access
    property p_write_addr_bounds;
        @(posedge clk_wire) write_addr < 64;
    endproperty
    assert property(p_write_addr_bounds);

endmodule