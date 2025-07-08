module tb_half_adder;

logic a, b, sum, carry;
half_adder dut (.a(a),.b(b),.sum(sum),.carry(carry));

always @(*) begin assert (@(posedge clk) ((a == 0 && b == 0) | (a == 1 && b == 0) | (a == 0 && b == 1) | (a == 1 && b == 1)) => (sum == (a ^ b))); end
always @(*) begin assert (@(posedge clk) ((a && b) | (a &&!b) | (!a && b)) => (carry == (a && b))); end
always @(*) begin assert (@(posedge clk) (!(a || b) |!(a && b)) |-> ##[1:1] (!carry)); end
always @(*) begin assert (@(posedge clk) (a && b) |-> ##[1:1] (carry)); end
always @(*) begin assert (@(posedge clk) ($fell(clk) |=> (~a == a) & (~b == b))); end

initial begin
    #10 clk = 1'b0; // Initialize clock
    forever #5 clk = ~clk; // Generate clock
end

endmodule