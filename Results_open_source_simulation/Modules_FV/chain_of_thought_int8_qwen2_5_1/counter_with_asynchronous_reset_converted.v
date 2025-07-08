module tb_counter (
    input clk,
    input reset,
    input ena,
    output reg [7:0] result
);
    
wire clk;
wire reset;
wire ena;
reg [7:0] result;

counter dut (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .result(result)
);

always #5 clk = ~clk;

always @(*) begin assert (@(posedge clk) ($rose(reset)) |-> (result == 8'b0)); end

always @(*) begin assert (@(posedge clk) (ena && !reset) |-> (result == result[6:0]+1)); end

always @(*) begin assert (@(posedge clk) (result == 8'hFF && ena && !reset) |-> ##1 result == 8'hFF); end

assert (@(posedge clk) (result == 8'hFE && ena && !reset) |-> ##1 result == 8'hFF;
	@(posedge clk) (result == 8'hFF && ena && !reset) |-> ##1 result == 8'hFF);

always @(*) begin assert (@(posedge clk) (!ena && !reset) |-> (result == result)); end

endmodule