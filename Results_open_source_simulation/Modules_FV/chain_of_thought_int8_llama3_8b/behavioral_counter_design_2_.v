module tb_behav_counter;

reg [7:0] d;

reg clk;

reg clear;

reg load;

reg up_down;

behav_counter uut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd());

property p_initial_value;
    @(posedge clk) disable iff (!clear) cnt == 8'h00;
endproperty

property p_load_value;
    @(posedge clk) disable iff (load) cnt == d;
endproperty

property p_up_down_increment;
    @(posedge clk) disable iff (up_down) cnt == cnt + 1;
endproperty

property p_up_down_decrement;
    @(posedge clk) disable iff (!up_down) cnt == cnt - 1;
endproperty

assert property (p_initial_value);
assert property (p_load_value);
assert property (p_up_down_increment);
assert property (p_up_down_decrement);

endmodule