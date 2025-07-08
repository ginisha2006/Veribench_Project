module tb_ram_infer (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input clk,
    output reg [7:0] q
);
    
    wire [7:0] data_wire;
    wire [5:0] read_addr_wire;
    wire [5:0] write_addr_wire;
    wire we_wire;
    wire clk_wire;

    assign data_wire = data;
    assign read_addr_wire = read_addr;
    assign write_addr_wire = write_addr;
    assign we_wire = we;
    assign clk_wire = clk;

    ram_infer dut (
        .data(data_wire),
        .read_addr(read_addr_wire),
        .write_addr(write_addr_wire),
        .we(we_wire),
        .clk(clk_wire),
        .q(q)
    );

    always #5 clk_wire = ~clk_wire;

    // Functional Correctness
    property prop_read_write;
        @(posedge clk) disable iff (!we)
            $rose(we) |-> ##1 q == data_wire;
    endproperty
    assert property(prop_read_write);

    // Edge Cases
    property prop_edge_cases;
        @(posedge clk) disable iff (!we)
            read_addr_wire == write_addr_wire |-> ##1 q == data_wire;
    endproperty
    assert property(prop_edge_cases);

    // Overflow/Underflow - Not applicable as address space is fixed

    // Illegal Transitions
    property prop_illegal_transitions;
        @(posedge clk) disable iff (!we)
            !($isunknown({data_wire, read_addr_wire, write_addr_wire, we_wire}));
    endproperty
    assert property(prop_illegal_transitions);

endmodule