module tb_ram_dual (
    input clk_read,
    input clk_write,
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    output reg [7:0] q
);
    
    wire [7:0] data_wire = data;
    wire [5:0] read_addr_wire = read_addr;
    wire [5:0] write_addr_wire = write_addr;
    wire we_wire = we;

    ram_dual dut (
        .data(data_wire),
        .read_addr(read_addr_wire),
        .write_addr(write_addr_wire),
        .we(we_wire),
        .read_clock(clk_read),
        .write_clock(clk_write),
        .q(q)
    );

    // Clock generation
    reg clk_read_gen;
    reg clk_write_gen;
    always #5 clk_read_gen = ~clk_read_gen;
    always #10 clk_write_gen = ~clk_write_gen;

    // Functional correctness
    property p_read_correctness;
        @(posedge clk_read) disable iff (!we || write_addr != read_addr)
            q == data ##1 read_addr == write_addr && we;
    endproperty
    assert property(p_read_correctness);

    // Edge case - simultaneous read/write on same address
    property p_simultaneous_rw;
        @(posedge clk_read, posedge clk_write) disable iff (!we)
            read_addr == write_addr |-> q == data;
    endproperty
    assert property(p_simultaneous_rw);

    // Overflow/Underflow - Address range check
    property p_address_range;
        @(posedge clk_read, posedge clk_write) disable iff (!we)
            read_addr < 64 && write_addr < 64;
    endproperty
    assert property(p_address_range);

    // Illegal transition - Write enable should not change state during a cycle
    property p_we_transition;
        @(posedge clk_write) disable iff (!we)
            !($past(we)) |=> we;
    endproperty
    assert property(p_we_transition);

endmodule