module tb_true_dpram_sclk;

logic [7:0] data_a, data_b;
logic [5:0] addr_a, addr_b;
logic we_a, we_b, clk;
logic [7:0] q_a, q_b;

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

always @(*) begin assert (@(posedge clk) disable iff (!we_a) ($rose(we_a) |=> ram[addr_a] == data_a)); end
always @(*) begin assert (@(posedge clk) disable iff (!we_a) ($fell(we_a) |=> q_a == ram[addr_a])); end
always @(*) begin assert (@(posedge clk) disable iff (!we_b) ($rose(we_b) |=> ram[addr_b] == data_b)); end
always @(*) begin assert (@(posedge clk) disable iff (!we_b) ($fell(we_b) |=> q_b == ram[addr_b])); end
always @(*) begin assert (@(posedge clk) disable iff ((we_a && we_b))!(addr_a == addr_b)); end
always @(*) begin assert (@(posedge clk) disable iff ((we_a || we_b))!(q_a == q_b)); end

endmodule