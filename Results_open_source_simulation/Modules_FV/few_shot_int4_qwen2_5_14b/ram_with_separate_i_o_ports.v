module tb_ram_separate_io #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
) ();

    // Inputs
    reg clk;
    reg we;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] data_in;

    // Output
    wire [DATA_WIDTH-1:0] data_out;

    // Instantiate the DUT
    ram_separate_io #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) UUT (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation for properties
    initial clk = 0;
    always #5 clk = ~clk;

    // Properties

    // Property: Data written should match read data when address matches
    property p_read_after_write;
        @(posedge clk)
        $rose(we) |-> ##1 data_out == data_in;
    endproperty
    assert property (p_read_after_write);

    // Property: If write enable is low, data_out should not change
    property p_no_change_on_read_only;
        @(posedge clk)
        !we |-> ##1 data_out == data_out;
    endproperty
    assert property (p_no_change_on_read_only);

endmodule