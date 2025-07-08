module tb_behav_counter;

parameter CLOCK_PERIOD = 10; // in ns

reg clk;
reg [7:0] d;
wire [7:0] qd;

behav_counter dut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd(qd));

always @(*) begin assert (@(posedge clk) disable iff (~clear) qd == 8'h00); end
always @(*) begin assert (@(posedge clk) disable iff (load) qd == d); end
always @(*) begin assert (@(posedge clk) disable iff (~clear & ~load & up_down) qd == qd + 1); end
always @(*) begin assert (@(posedge clk) disable iff (~clear & ~load & ~up_down) qd == qd - 1); end
always @(*) begin assert (@(posedge clk) disable iff (~clear & ~load & up_down && qd == 8'hff) qd == 8'h00); end
always @(*) begin assert (@(posedge clk) disable iff (~clear & ~load & ~up_down && qd == 8'h00) qd == 8'hff); end

initial begin
    #((CLOCK_PERIOD / 2); clk = 1'b1; #CLOCK_PERIOD; clk = 1'b0; forever #(CLOCK_PERIOD) clk =!clk;
end

endmodule