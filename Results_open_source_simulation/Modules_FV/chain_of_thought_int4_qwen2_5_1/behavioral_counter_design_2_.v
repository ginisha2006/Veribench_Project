module tb_behav_counter(
    input [7:0] d,
    input clk,
    input clear,
    input load,
    input up_down,
    output reg [7:0] cnt
);

property reset_assertion;
 @(posedge clk) !clear |-> cnt == 8'b0;
endproperty
assert property(reset_assertion);

property load_assertion;
 @(posedge clk) load && clear ##1 load |-> cnt[7:0] == d;
endproperty
assert property(load_assertion);

property increment_decrement;
 @(posedge clk) up_down |=> cnt[7:0] inside {[1:254]};
 @(posedge clk) !up_down |=> cnt[7:0] inside {[1:254]};
endproperty
assert property(increment_decrement);

property overflow_underflow;
 @(posedge clk) up_down |-> cnt != 8'd255 || cnt == 8'd254;
 @(posedge clk) !up_down |-> cnt != 8'd0 || cnt == 8'd1;
endproperty
assert property(overflow_underflow);

property transition_clear_load;
 @(posedge clk) clear && load |-> cnt == 8'b0;
endproperty
assert property(transition_clear_load);

endmodule