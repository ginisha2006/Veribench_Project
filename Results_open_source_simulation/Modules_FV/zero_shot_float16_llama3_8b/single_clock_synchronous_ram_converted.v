module tb_ram_infer;

reg [7:0] data;
reg [5:0] read_addr, write_addr;
reg we;
reg clk;
wire [7:0] q;

ram_infer dut (
   .data(data),
   .read_addr(read_addr),
   .write_addr(write_addr),
   .we(we),
   .clk(clk),
   .q(q)
);

always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(we))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($fell(read_addr))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) (q == dut.ram[dut.write_addr])); end
always @(*) begin assert (@(posedge clk) disable iff (!we) (q == dut.ram[dut.read_addr])); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((dut.write_addr >= 63) | (dut.write_addr < 0))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((dut.read_addr >= 63) | (dut.read_addr < 0))); end

always #10 clk = ~clk; // Clock generation

initial begin
    clk = 1'b0;
    repeat (100) @(posedge clk); // Run for 100 cycles
end

endmodule