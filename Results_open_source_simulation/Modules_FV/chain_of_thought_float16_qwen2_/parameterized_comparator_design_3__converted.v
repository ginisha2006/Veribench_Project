module tb_param_comparator (
    input [7:0] A,
    input [7:0] B,
    output reg Equal,
    output reg Greater,
    output reg Less,
    input clk
);

assert (@(posedge clk) disable iff (!reset)
 (A == B) |-> Equal === 1'b1);

assert (@(posedge clk) disable iff (!reset)
 (A > B) |-> Greater === 1'b1);

assert (@(posedge clk) disable iff (!reset)
 (A < B) |-> Less === 1'b1);

assert (@(posedge clk) disable iff (!reset)
 !(Equal & Greater & Less));

assert (@(posedge clk) disable iff (!reset)
 ((A == 8'd0) && (B == 8'd0)) |-> Equal === 1'b1;
 ((A == 8'd255) && (B == 8'd254)) |-> Greater === 1'b1;
 ((A == 8'd1) && (B == 8'd255)) |-> Less === 1'b1);

endmodule