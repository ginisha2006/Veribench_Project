module tb_behav_counter;

logic [7:0] d;
logic clk;
logic clear;
logic load;
logic up_down;
logic [7:0] cnt;

behav_counter dut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd(cnt));

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

property p_overflow;
    @(posedge clk) disable iff (cnt == 8'hff &&!up_down) cnt == 8'h00;
endproperty

property p_underflow;
    @(posedge clk) disable iff (cnt == 8'h00 && up_down) cnt == 8'hff;
endproperty

assert property (p_initial_value);
assert property (p_load_value);
assert property (p_up_down_increment);
assert property (p_up_down_decrement);
assert property (p_overflow);
assert property (p_underflow);

endmodule