module tb_ram_infer;

parameter CLOCK_PERIOD = 10; // adjust this value according to your requirements

logic [7:0] data;
logic [5:0] read_addr, write_addr;
logic we, clk;
logic [7:0] q;

ram_infer dut (
   .data(data),
   .read_addr(read_addr),
   .write_addr(write_addr),
   .we(we),
   .clk(clk),
   .q(q)
);

property p_read_correct;
    @(posedge clk) disable iff (!we);
    q == dut.ram[dut.write_addr];
endproperty

property p_write_correct;
    @(posedge clk) disable iff (!we);
    dut.ram[dut.write_addr] == data;
endproperty

property p_overflow;
    @(posedge clk) disable iff (!we && dut.write_addr >= 63);
    assert property (p_overflow) else $error("RAM overflow detected");
endproperty

property p_underflow;
    @(posedge clk) disable iff (!we && dut.read_addr >= 63);
    assert property (p_underflow) else $error("RAM underflow detected");
endproperty

property p_edge_cases;
    @(posedge clk) disable iff (!we);
   !dut.we |-> ##1!dut.we;
endproperty

property p_timing_constraint;
    @(posedge clk) disable iff (!we);
    ##1 => dut.q == dut.ram[dut.read_addr];
endproperty

assert property (p_read_correct);
assert property (p_write_correct);
assert property (p_overflow);
assert property (p_underflow);
assert property (p_edge_cases);
assert property (p_timing_constraint);

always #CLOCK_PERIOD clk = ~clk;

endmodule