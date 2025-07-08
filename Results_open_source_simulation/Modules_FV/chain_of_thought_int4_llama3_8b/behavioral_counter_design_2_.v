module tb_behav_counter;

reg [7:0] d;
reg clk;
reg clear;
reg load;
reg up_down;
wire [7:0] cnt;

behav_counter dut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd(cnt));

property p_clear_initial_value;
@(posedge clk) disable iff (!clear);
cnt == 8'h00;
endproperty

property p_load_correct;
@(posedge clk) disable iff (load &&!clear);
cnt == d;
endproperty

property p_up_down_increment;
@(posedge clk) disable iff (up_down &&!clear &&!load);
cnt + 1 == cnt;
endproperty

property p_down_decrement;
@(posedge clk) disable iff ((up_down == 1'b0) &&!clear &&!load);
cnt - 1 == cnt;
endproperty

property p_edge_cases;
@(posedge clk) disable iff (clear || load);
!(cnt!= 8'h00 || cnt!= d);
endproperty

assert property (p_clear_initial_value);
assert property (p_load_correct);
assert property (p_up_down_increment);
assert property (p_down_decrement);
assert property (p_edge_cases);

endmodule