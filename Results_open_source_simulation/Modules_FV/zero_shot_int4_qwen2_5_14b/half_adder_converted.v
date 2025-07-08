module tb_half_adder (
    input a,
    input b,
    output sum,
    output carry
);

wire clk;

always begin
    #5 clk = ~clk;
end

half_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

always @(*) begin assert (@(posedge clk) a && b |-> sum == a ^ b); end

always @(*) begin assert (@(posedge clk) a && b |-> carry == a & b); end

always @(*) begin assert (@(posedge clk) !overflow && !underflow); end

endmodule