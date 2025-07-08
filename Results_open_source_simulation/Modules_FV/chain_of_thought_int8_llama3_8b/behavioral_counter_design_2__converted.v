module tb_behav_counter;

reg [7:0] d;

reg clk;

reg clear;

reg load;

reg up_down;

behav_counter uut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd());

always @(*) begin assert (@(posedge clk) disable iff (!clear) cnt == 8'h00); end
always @(*) begin assert (@(posedge clk) disable iff (load) cnt == d); end
always @(*) begin assert (@(posedge clk) disable iff (up_down) cnt == cnt + 1); end
always @(*) begin assert (@(posedge clk) disable iff (!up_down) cnt == cnt - 1); end

endmodule