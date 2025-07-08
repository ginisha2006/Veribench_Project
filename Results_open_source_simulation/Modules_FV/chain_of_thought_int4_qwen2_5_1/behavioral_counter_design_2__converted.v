module tb_behav_counter(
    input [7:0] d,
    input clk,
    input clear,
    input load,
    input up_down,
    output reg [7:0] cnt
);

always @(*) begin assert (@(posedge clk) !clear |-> cnt == 8'b0); end

always @(*) begin assert (@(posedge clk) load && clear ##1 load |-> cnt[7:0] == d); end

assert (@(posedge clk) up_down |=> cnt[7:0] inside {[1:254]};
 @(posedge clk) !up_down |=> cnt[7:0] inside {[1:254]});

assert (@(posedge clk) up_down |-> cnt != 8'd255 || cnt == 8'd254;
 @(posedge clk) !up_down |-> cnt != 8'd0 || cnt == 8'd1);

always @(*) begin assert (@(posedge clk) clear && load |-> cnt == 8'b0); end

endmodule