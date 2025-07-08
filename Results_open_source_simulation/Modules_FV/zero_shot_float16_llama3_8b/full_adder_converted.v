module tb_full_adder;

logic a, b, cin, sum, cout;
full_adder dut (.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));

always @(*) begin assert (@(posedge clk) ((a ^ b ^ cin) === sum)); end
always @(*) begin assert (@(posedge clk) (((a & b) | (b & cin) | (a & cin)) === cout)); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ((a == 1'b1 && b == 1'b1 && cin == 1'b1) | (a == 1'b1 && b == 1'b1 && cin == 1'b0) | (a == 1'b1 && b == 1'b0 && cin == 1'b1))); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ((a == 1'b0 && b == 1'b0 && cin == 1'b0) | (a == 1'b0 && b == 1'b0 && cin == 1'b1) | (a == 1'b0 && b == 1'b1 && cin == 1'b0))); end
always @(*) begin assert (@(posedge clk) disable iff (!clk) ((a == 1'b0 && b == 1'b0 && cin == 1'b0) | (a == 1'b0 && b == 1'b0 && cin == 1'b1) | (a == 1'b0 && b == 1'b1 && cin == 1'b0) | (a == 1'b1 && b == 1'b0 && cin == 1'b0) | (a == 1'b1 && b == 1'b1 && cin == 1'b0) | (a == 1'b1 && b == 1'b1 && cin == 1'b1))); end

endmodule