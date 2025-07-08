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

always @(*) begin assert (@(posedge clk) disable iff (!we_a) ($rose(we_a) |=> $stable(ram[addr_a]))); end
always @(*) begin assert (@(posedge clk) disable iff (!we_a) ($fell(we_a) |=> $stable(q_a))); end
always @(*) begin assert (@(posedge clk) disable iff (!we_b) ($rose(we_b) |=> $stable(ram[addr_b]))); end
always @(*) begin assert (@(posedge clk) disable iff (!we_b) ($fell(we_b) |=> $stable(q_b))); end
always @(*) begin assert (@(posedge clk) disable iff (!we_a) ((addr_a < 64) |=> $stable(ram[addr_a]))); end
always @(*) begin assert (@(posedge clk) disable iff (!we_b) ((addr_b < 64) |=> $stable(ram[addr_b]))); end
always @(*) begin assert (@(posedge clk) disable iff (!we_a) (!(addr_a >= 64) |=> $stable(ram[addr_a]))); end
always @(*) begin assert (@(posedge clk) disable iff (!we_b) (!(addr_b >= 64) |=> $stable(ram[addr_b]))); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ($fell(clk) |=> $stable({q_a, q_b}))); end

always #10 clk = ~clk;

initial begin
    clk = 1'b0;
    repeat (100) #10 clk = ~clk;
end

endmodule