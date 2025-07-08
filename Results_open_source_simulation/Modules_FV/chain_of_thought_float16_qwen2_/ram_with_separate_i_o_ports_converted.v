module tb_ram_separate_io (
    input clk,
    input we,
    input [7:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg clk;

always #5 clk = ~clk;

assert (@(posedge clk) disable iff (!we)
    ##1 data_out == data_in |-> ##1 data_out == data_in);

assert (@(posedge clk) disable iff (!we)
    ##1 data_out != data_in |=> ##1 data_out == data_in);

always @(*) begin assert (@(posedge clk) addr < 8'd256); end

always @(*) begin assert (@(posedge clk) !we |=> data_out == data_out); end

always @(*) begin assert (@(posedge clk) !(data_in > 8'hFF || data_in < 8'h00)); end

always @(*) begin assert (@(posedge clk) we !== we); end

endmodule