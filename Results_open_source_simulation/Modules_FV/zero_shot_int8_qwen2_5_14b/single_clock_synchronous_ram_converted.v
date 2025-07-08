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
    assert (@(posedge clk_wire) disable iff (!we)
            ($past(we)) |-> q == data);

    // Edge case - simultaneous read/write on same address
    assert (@(posedge clk_wire) disable iff (!we)
            (write_addr == read_addr) |-> $stable(q));

    // Over/Underflow check is not applicable as addresses are bounded within [0:63]

    // Illegal transition - write enable should not change state without clock edge
    assert (@(negedge clk_wire) disable iff (!we)
            !($rose(we)));

    // Ensure read address does not cause out-of-bounds access
    always @(*) begin assert (@(posedge clk_wire) read_addr < 64); end

    // Ensure write address does not cause out-of-bounds access
    always @(*) begin assert (@(posedge clk_wire) write_addr < 64); end

endmodule