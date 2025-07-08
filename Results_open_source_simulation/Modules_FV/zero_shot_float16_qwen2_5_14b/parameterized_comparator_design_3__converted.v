module tb_param_comparator (
    input [7:0] A,
    input [7:0] B,
    output reg Equal,
    output reg Greater,
    output reg Less
);

wire clk;
reg [7:0] A_in;
reg [7:0] B_in;

param_comparator #(.WIDTH(8)) dut (
    .A(A_in),
    .B(B_in),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
);

always begin
    clk = 1'b0; #5;
    clk = 1'b1; #5;
end

assert (@(posedge clk) disable iff (!reset)
    (A_in == B_in) |-> (Equal === 1'b1));

assert (@(posedge clk) disable iff (!reset)
    (A_in > B_in) |-> (Greater === 1'b1));

assert (@(posedge clk) disable iff (!reset)
    (A_in < B_in) |-> (Less === 1'b1));

assert (@(posedge clk) disable iff (!reset)
    !(Equal & Greater & Less));

endmodule