module tb_true_dpram_sclk;

parameter CLOCK_PERIOD = 10; // adjust this value according to your requirements

logic [7:0] data_a, data_b;
logic [5:0] addr_a, addr_b;
logic we_a, we_b;
logic clk;
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

property p_write_data_a;
@(posedge clk) disable iff (!we_a) q_a == ram[dut.addr_a];
endproperty

property p_read_data_a;
@(posedge clk) disable iff (we_a) q_a!= ram[dut.addr_a];
endproperty

property p_write_data_b;
@(posedge clk) disable iff (!we_b) q_b == ram[dut.addr_b];
endproperty

property p_read_data_b;
@(posedge clk) disable iff (we_b) q_b!= ram[dut.addr_b];
endproperty

property p_addr_range;
((addr_a < 64) && (addr_a >= 0)) |-> (q_a == ram[addr_a]);
((addr_b < 64) && (addr_b >= 0)) |-> (q_b == ram[addr_b]);
endproperty

property p_overflow_underflow;
!(addr_a >= 64 || addr_b >= 64);
endproperty

assert property (p_write_data_a);
assert property (p_read_data_a);
assert property (p_write_data_b);
assert property (p_read_data_b);
assert property (p_addr_range);
assert property (p_overflow_underflow);

endmodule