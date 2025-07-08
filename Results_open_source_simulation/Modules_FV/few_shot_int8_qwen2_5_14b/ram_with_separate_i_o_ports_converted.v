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
    ram_separate_io #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH))
                    UUT (
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

    // Property: Data written should match data read when address matches
    assert (@(posedge clk) disable iff (!we)
            ##1 data_out == data_in |-> (we && (##1 addr === addr)));

    // Property: If write enable is low, data out should remain unchanged from previous cycle
    assert (@(posedge clk) disable iff (we)
            !we |=> (data_out === ##1 data_out));

endmodule