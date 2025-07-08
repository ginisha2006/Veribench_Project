module tb_behav_counter;

parameter CLOCK_PERIOD = 10; // in ns

logic clk;
logic [7:0] d;
logic clear;
logic load;
logic up_down;
logic [7:0] qd;

behav_counter dut (
   .d(d),
   .clk(clk),
   .clear(clear),
   .load(load),
   .up_down(up_down),
   .qd(qd)
);

always @(*) begin assert (@(posedge clk) disable iff (!clear) qd == 8'h00); end
always @(*) begin assert (@(posedge clk) disable iff (load) qd == d); end
always @(*) begin assert (@(posedge clk) disable iff (!clear &&!load && up_down) qd == qd + 1); end
always @(*) begin assert (@(posedge clk) disable iff (!clear &&!load &&!up_down) qd == qd - 1); end
always @(*) begin assert (@(posedge clk) disable iff (!clear &&!load && up_down && qd == 8'hff) $fatal("Overflow")); end
always @(*) begin assert (@(posedge clk) disable iff (!clear &&!load &&!up_down && qd == 8'h00) $fatal("Underflow")); end

always #CLOCK_PERIOD clk = ~clk;

initial begin
    clk = 0;
    forever #(CLOCK_PERIOD/2) clk = ~clk;
end

endmodule