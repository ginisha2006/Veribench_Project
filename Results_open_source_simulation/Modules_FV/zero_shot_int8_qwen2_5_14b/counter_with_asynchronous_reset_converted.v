module tb_counter (
    input clk,
    input reset,
    input ena,
    output reg [7:0] result
);
    wire [7:0] result_wire;

    counter dut (
        .clk(clk),
        .reset(reset),
        .ena(ena),
        .result(result_wire)
    );

    always #5 clk =~clk; // Clock signal generation

    always @(*) begin assert (@(posedge clk) reset |-> ##1 result == 8'b0); end

    always @(*) begin assert (@(posedge clk) ~reset && ena |=> ##1 result == result_wire + 1); end

    always @(*) begin assert (@(posedge clk) ~reset && !ena |-> ##1 result == result_wire); end

    always @(*) begin assert (@(posedge clk) result == 8'hFF |-> ##1 reset || result == 8'h0); end
endmodule