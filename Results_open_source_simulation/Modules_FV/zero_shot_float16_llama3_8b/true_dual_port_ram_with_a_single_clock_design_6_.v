module tb_true_dpram_sclk;

reg [7:0] data_a, data_b;
reg [5:0] addr_a, addr_b;
reg we_a, we_b;
reg clk;
wire [7:0] q_a, q_b;

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

property p_write_port_a;
    @(posedge clk) disable iff (!we_a) ($rose(we_a) |=> $stable(ram[addr_a]));
endproperty

property p_read_port_a;
    @(posedge clk) disable iff (!we_a) ($fell(we_a) |=> $stable(q_a));
endproperty

property p_write_port_b;
    @(posedge clk) disable iff (!we_b) ($rose(we_b) |=> $stable(ram[addr_b]));
endproperty

property p_read_port_b;
    @(posedge clk) disable iff (!we_b) ($fell(we_b) |=> $stable(q_b));
endproperty

property p_no_overflow_addr_a;
    @(posedge clk) disable iff (!we_a) ((addr_a < 64) |=> $stable(ram[addr_a]));
endproperty

property p_no_overflow_addr_b;
    @(posedge clk) disable iff (!we_b) ((addr_b < 64) |=> $stable(ram[addr_b]));
endproperty

property p_no_underflow_addr_a;
    @(posedge clk) disable iff (!we_a) (!(addr_a >= 64) |=> $stable(ram[addr_a]));
endproperty

property p_no_underflow_addr_b;
    @(posedge clk) disable iff (!we_b) (!(addr_b >= 64) |=> $stable(ram[addr_b]));
endproperty

property p_clock_domain_crossing;
    @(posedge clk) disable iff (!clk) ($fell(clk) |=> $stable({q_a, q_b}));
endproperty

assert property (p_write_port_a);
assert property (p_read_port_a);
assert property (p_write_port_b);
assert property (p_read_port_b);
assert property (p_no_overflow_addr_a);
assert property (p_no_overflow_addr_b);
assert property (p_no_underflow_addr_a);
assert property (p_no_underflow_addr_b);
assert property (p_clock_domain_crossing);

always #10 clk = ~clk;

initial begin
    clk = 1'b0;
    repeat (100) #10 clk = ~clk;
end

endmodule