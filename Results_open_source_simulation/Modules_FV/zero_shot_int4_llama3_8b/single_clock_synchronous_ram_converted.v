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

always @(*) begin assert (@(posedge clk) disable iff (!we); end
    q == dut.ram[dut.write_addr]);
always @(*) begin assert (@(posedge clk) disable iff (!we); end
    dut.ram[dut.write_addr] == data);
always @(*) begin assert (@(posedge clk) disable iff (!we && dut.write_addr >= 63); end
    assert property (p_overflow) else $error("RAM overflow detected"));
always @(*) begin assert (@(posedge clk) disable iff (!we && dut.read_addr >= 63); end
    assert property (p_underflow) else $error("RAM underflow detected"));
always @(*) begin assert (@(posedge clk) disable iff (!we); end
   !dut.we |-> ##1!dut.we);
always @(*) begin assert (@(posedge clk) disable iff (!we); end
    ##1 => dut.q == dut.ram[dut.read_addr]);

always #CLOCK_PERIOD clk = ~clk;

endmodule