module tb_rom_simple (
    input [7:0] addr,
    output reg [7:0] data_out
);

wire clk;
reg [7:0] addr_in;

assign data_out = addr_in;

assert (@(posedge clk) disable iff (!reset_n)
    (addr inside {[0 : 255]]) |-> ##1 data_out != 8'bzzzzzzzz);

assert (@(posedge clk) disable iff (!reset_n)
    !(addr inside {[0 : 255}]) |=> data_out == 8'bzzzzzzzz);

assert (@(posedge clk) disable iff (!reset_n)
    !(addr inside {[0 : 255}]) |-> ##1 data_out == ##1 data_out);

always begin
    clk = 1'b0; #5;
    clk = 1'b1; #5;
end

endmodule