module tb_true_dpram_sclk (
    input [7:0] data_a, data_b,
    input [5:0] addr_a, addr_b,
    input we_a, we_b, clk,
    output reg [7:0] q_a, q_b
);

reg [7:0] ram[63:0];

assert (@(posedge clk)
	(we_a |-> ##1 q_a == data_a) else (q_a == ram[addr_a]));

assert (@(posedge clk)
	(we_b |-> ##1 q_b == data_b) else (q_b == ram[addr_b]));

assert (@(posedge clk)
	addr_a inside {[0:63]});

assert (@(posedge clk)
	addr_b inside {[0:63]});

assert (@(posedge clk)
	(!we_a |=> q_a == ram[addr_a]));

assert (@(posedge clk)
	(!we_b |=> q_b == ram[addr_b]));

assert (@(posedge clk)
	(we_a && we_b |-> ##1 {q_a == data_a, q_b == data_b}));

assert (@(posedge clk)
	($past(q_a) == ram[$past(addr_a)]) || ($past(q_b) == ram[$past(addr_b)]));

endmodule