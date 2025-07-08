module tb_true_dpram_sclk();
    // Signal declarations
    logic [7:0] data_a, data_b;
    logic [5:0] addr_a, addr_b;
    logic we_a, we_b, clk;
    logic [7:0] q_a, q_b;

    // DUT instantiation
    true_dpram_sclk dut (
       .data_a(data_a),
       .data_b(data_b),
       .addr_a(addr_a),
       .addr_b(addr_b),
       .we_a(we_a),
       .we_b(we_b),
       .clk(clk),
       .q_a(q_a),
       .q_b(q_b)
    );

    // Clock signal generation
    always #10 clk = ~clk;

    // Property-based assertions
    always @(*) begin assert (@(posedge clk) disable iff (!we_a &&!we_b) ($rose(we_a) | $rose(we_b)) => (q_a == data_a) && (q_b == data_b)); end
    always @(*) begin assert (@(posedge clk) disable iff (!we_a &&!we_b) (!we_a &&!we_b) => (q_a == ram[addr_a]) && (q_b == ram[addr_b])); end
    always @(*) begin assert (@(posedge clk) disable iff (!we_a &&!we_b) ((addr_a < 64) && (addr_b < 64))); end
    always @(*) begin assert (@(posedge clk) disable iff (!we_a &&!we_b) (we_a && we_b)); end

endmodule