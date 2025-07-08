module tb_param_subtractor;

parameter WIDTH = 8;

logic [WIDTH-1:0] a, b;

logic [WIDTH-1:0] diff;

logic borrow;

param_subtractor #(.WIDTH(WIDTH)) dut (.a(a),.b(b),.diff(diff),.borrow(borrow));

property p_diff_valid;

@(posedge clk) ((|a| < |b|) => ($rose(borrow));

@(negedge clk) ((|a| > |b|) => ($fell(borrow));

@(posedge clk) ((a == b) => (!borrow && diff == 0));

assert property (p_diff_valid);

endmodule