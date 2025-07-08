module tb_behav_counter;

parameter CLOCK_PERIOD = 10; // in ns

reg clk;
reg [7:0] d;
wire [7:0] qd;

behav_counter dut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd(qd));

property p_initial_value;
@(posedge clk) disable iff (~clear) qd == 8'h00;
endproperty

property p_load_value;
@(posedge clk) disable iff (load) qd == d;
endproperty

property p_up_down_increment;
@(posedge clk) disable iff (~clear & ~load & up_down) qd == qd + 1;
endproperty

property p_up_down_decrement;
@(posedge clk) disable iff (~clear & ~load & ~up_down) qd == qd - 1;
endproperty

property p_overflow;
@(posedge clk) disable iff (~clear & ~load & up_down && qd == 8'hff) qd == 8'h00;
endproperty

property p_underflow;
@(posedge clk) disable iff (~clear & ~load & ~up_down && qd == 8'h00) qd == 8'hff;
endproperty

assert property (p_initial_value);
assert property (p_load_value);
assert property (p_up_down_increment);
assert property (p_up_down_decrement);
assert property (p_overflow);
assert property (p_underflow);

initial begin
    #((CLOCK_PERIOD / 2); clk = 1'b1; #CLOCK_PERIOD; clk = 1'b0; forever #(CLOCK_PERIOD) clk =!clk;
end

endmodule