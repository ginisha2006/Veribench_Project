module tb_ram_simple (
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
);

    wire clk;
    wire we;
    wire [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;

    // Clock generation
    reg clk_gen;
    always #5 clk_gen = ~clk_gen;
    assign clk = clk_gen;

    // Instantiate DUT
    ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Properties
    property read_after_write;
        @(posedge clk) disable iff (!we)
        ($past(we) && $past(addr) == addr) |-> data_out == $past(data_in);
    endproperty
    assert property(read_after_write);

    property write_order;
        @(posedge clk) disable iff (!we)
        we ##1 we |-> $past(addr) != addr;
    endproperty
    assert property(write_order);

    property no_read_without_clock_edge;
        @(posedge clk) disable iff (!we)
        !($rose(we) || $fell(we)) |-> data_out == $stable(mem[$past(addr)]);
    endproperty
    assert property(no_read_without_clock_edge);

endmodule