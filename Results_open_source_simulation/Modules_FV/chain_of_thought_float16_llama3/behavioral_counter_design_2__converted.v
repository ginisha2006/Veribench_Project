module tb_behav_counter;

logic [7:0] d;
logic clk;
logic clear;
logic load;
logic up_down;
logic [7:0] cnt;

behav_counter dut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd(cnt));

always @(*) begin assert (@(posedge clk) disable iff (!clear) cnt == 8'h00); end
always @(*) begin assert (@(posedge clk) disable iff (load) cnt == d); end
always @(*) begin assert (@(posedge clk) disable iff (up_down) cnt == cnt + 1); end
always @(*) begin assert (@(posedge clk) disable iff (!up_down) cnt == cnt - 1); end
always @(*) begin assert (@(posedge clk) disable iff (cnt == 8'hff &&!up_down) cnt == 8'h00); end
always @(*) begin assert (@(posedge clk) disable iff (cnt == 8'h00 && up_down) cnt == 8'hff); end

endmodule