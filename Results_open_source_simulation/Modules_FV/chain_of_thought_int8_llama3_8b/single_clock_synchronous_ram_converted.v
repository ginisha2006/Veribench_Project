module tb_ram_infer;

parameter TIMEUNIT = 10ns;

reg clk;
reg [7:0] data;
reg [5:0] read_addr, write_addr;
reg we;

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
always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(data))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($stable(q))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(write_addr))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($stable(read_addr))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((write_addr > 63) | (read_addr > 63))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((write_addr < 0) | (read_addr < 0))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((write_addr == read_addr) & (we))); end

always #TIMEUNIT clk = ~clk;

initial begin
    clk <= 0;
    repeat (100) @(posedge clk);
    $finish;
end

endmodule