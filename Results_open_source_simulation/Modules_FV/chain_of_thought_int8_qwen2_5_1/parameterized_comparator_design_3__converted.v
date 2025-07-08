module tb_param_comparator (
    input [7:0] A,
    input [7:0] B,
    output reg Equal,
    output reg Greater,
    output reg Less,
    input clk
);

wire [7:0] A;
wire [7:0] B;
reg Equal;
reg Greater;
reg Less;

param_comparator #(.WIDTH(8)) dut (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
);

always begin
    clk = 1'b0; #(5); clk = 1'b1; #(5);
end

assert (@(posedge clk) disable iff (!reset)
    (A == B) |-> Equal === 1'b1 else Equal === 1'b0);

assert (@(posedge clk) disable iff (!reset)
    (A > B) |-> Greater === 1'b1 else Greater === 1'b0);

assert (@(posedge clk) disable iff (!reset)
    (A < B) |-> Less === 1'b1 else Less === 1'b0);

assert (@(posedge clk) disable iff (!reset)
    !(Equal & Greater) && !(Equal & Less) && !(Greater & Less));

assert (@(posedge clk) disable iff (!reset)
    ($past(A == 8'hFF) && $rose(B)) |=> !Equal && !Greater && Less);

assert (@(posedge clk) disable iff (!reset)
    !$isunknown({A,B}) |-> !($signed(A) < $signed(B) && $signed(B) - $signed(A) >= 2**WIDTH));

assert (@(posedge clk) disable iff (!reset)
    !$isunknown({A,B}) |-> !($signed(A) > $signed(B) && $signed(A) - $signed(B) >= 2**WIDTH));

endmodule