module tb_ram_separate_io;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;

    logic clk;
    logic we;
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] data_in;
    logic [DATA_WIDTH-1:0] data_out;

    // Instantiate the Design Under Test (DUT)
    ram_separate_io #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock signal generation
    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end

    // Functional correctness assertion
    assert (@(posedge clk) disable iff (!we)
        ($past(we) && $past(addr) == addr) |-> data_out == $past(data_in));

    // Edge case - write enable is high but address changes before next rising edge
    assert (@(posedge clk) disable iff (!we)
        we ##1 !($past(addr) == addr) |-> ##1 data_out != $past(data_in));

    // Overwrite check when writing to same address multiple times
    assert (@(posedge clk) disable iff (!we)
        we && $past(we) && $past(addr) == addr |-> data_out == data_in);

    // Illegal transition - write enable should not change state within a single clock cycle
    assert (@(posedge clk) disable iff (!we)
        we && $rose(we) |-> ##1 !$past(we));

endmodule