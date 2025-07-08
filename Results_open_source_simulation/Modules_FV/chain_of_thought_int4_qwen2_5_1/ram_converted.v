module tb_ram_simple (
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8
);

    wire clk;
    wire we;
    wire [ADDR_WIDTH-1:0] addr;
    wire [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;

    ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    always begin
        clk = 0; #5; clk = 1; #5;
    end

    assert (@(posedge clk) disable iff (!we)
        ##1 data_out == data_in);

    assert (@(posedge clk) disable iff (!we)
        addr < (1 << ADDR_WIDTH));

    assert (@(posedge clk)
        addr < (1 << ADDR_WIDTH));

endmodule