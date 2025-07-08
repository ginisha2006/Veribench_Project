module tb_ram_infer (
    input [7:0] data,
    input [5:0] read_addr,
    input [5:0] write_addr,
    input we,
    input clk,
    output reg [7:0] q
);
    
    wire clk_wire;

    // DUT instantiation
    ram_infer dut (
        .data(data),
        .read_addr(read_addr),
        .write_addr(write_addr),
        .we(we),
        .clk(clk_wire),
        .q(q)
    );

    // Clock generation
    always begin
        clk_wire = 1'b0; #5;
        clk_wire = 1'b1; #5;
    end
    
    // Functional correctness
    assert (@(posedge clk_wire) disable iff (!we)
            ##1 q == data |-> (read_addr === write_addr)); 

    // Edge case - Write then Read immediately
    assert (@(posedge clk_wire) disable iff (!we)
            ##1 read_addr === write_addr |-> ##1 q == data);

    // Over/Under flow check is not applicable here as address space is fixed and bounded

    // Illegal transition - We should not read/write without enabling we
    always @(*) begin assert (@(posedge clk_wire) !we |=> !(q !== data)); end

endmodule