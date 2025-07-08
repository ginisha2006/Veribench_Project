module tb_behav_counter;

reg [7:0] d;
reg clk;
reg clear;
reg load;
reg up_down;
wire [7:0] cnt;

behav_counter dut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd(cnt));

always @(*) begin assert (@(posedge clk) disable iff (!clear); end
cnt == 8'h00);
always @(*) begin assert (@(posedge clk) disable iff (load &&!clear); end
cnt == d);
always @(*) begin assert (@(posedge clk) disable iff (up_down &&!clear &&!load); end
cnt + 1 == cnt);
always @(*) begin assert (@(posedge clk) disable iff ((up_down == 1'b0) &&!clear &&!load); end
cnt - 1 == cnt);
always @(*) begin assert (@(posedge clk) disable iff (clear || load); end
!(cnt!= 8'h00 || cnt!= d));

endmodule