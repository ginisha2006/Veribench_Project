module tb_ram_simple (
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
);

    // Signals
    wire clk;
    wire we;
    wire [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;

    // DUT instantiation
    ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    // Clock generation
    always begin
        clk = 1'b0; #5;
        clk = 1'b1; #5;
    end

    // Properties
    assert (@(posedge clk) disable iff (!we)
        ##1 data_out == data_in |-> mem[addr] == data_in);

    assert (@(posedge clk) disable iff (!we)
        !we |=> mem[addr] != data_in);

    always @(*) begin assert (@(posedge clk) addr < (2**ADDR_WIDTH)); end

    assert (@(posedge clk) disable iff (!we)
        !we |-> data_out == mem[addr]);

endmodule