module tb_ram_separate_io (
    input clk,
    input we,
    input [7:0] addr,
    input [7:0] data_in,
    output reg [7:0] data_out
);

reg [7:0] ram[255:0];

always begin
    clk = ~clk;
    #(5ns);
end

assert (@(posedge clk) disable iff (!we)
    ##1 data_out == ram[addr]);

assert (@(posedge clk) disable iff (!we)
    ##1 ram[addr] == data_in);

assert (@(posedge clk) disable iff (we)
    ##1 data_out !== ram[addr]);

always @(*) begin assert (@(posedge clk) addr inside {[0:255]}); end

endmodule