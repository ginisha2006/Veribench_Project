module tb_true_dpram_sclk (
    input wire clk,
    input wire [7:0] data_a, data_b,
    input wire [5:0] addr_a, addr_b,
    input wire we_a, we_b,
    output reg [7:0] q_a, q_b
);

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

reg clk_signal;

always #10 clk_signal = ~clk_signal;
assign clk = clk_signal;

assert (@(posedge clk) disable iff (!we_a)
	addr_a < 64);

assert (@(posedge clk) disable iff (!we_b)
	addr_b < 64);

assert (@(posedge clk) disable iff (!(we_a & we_b))
	addr_a == addr_b |-> ##1 q_a != data_b & q_b != data_a);

assert (@(posedge clk) disable iff (!we_a && !we_b)
	q_a == ram[addr_a] |=> q_a == ram[addr_a]);

assert (@(posedge clk) disable iff (we_a)
	q_a == data_a);

assert (@(posedge clk) disable iff (we_b)
	q_b == data_b);

assert (@(posedge clk) disable iff ((we_a && we_b) && (addr_a == addr_b))
	q_a == data_a & q_b == data_b);

endmodule