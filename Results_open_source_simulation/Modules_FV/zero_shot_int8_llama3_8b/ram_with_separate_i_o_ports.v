module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_separate_io dut (.clk(clk),.we(we),.addr(addr),.data_in(data_in),.data_out(data_out));

always #10 clk = ~clk;

property p_write_correctness;
@(posedge clk) disable iff (!we) data_out == dut.ram[addr];
assert property (p_write_correctness);

property p_read_correctness;
@(posedge clk) disable iff (we) data_out == dut.ram[addr];
assert property (p_read_correctness);

property p_overflow;
@(posedge clk) disable iff ((|addr) >= (1 << ADDR_WIDTH)) $display("Overflow detected");
assert property (~p_overflow);

property p_underflow;
@(posedge clk) disable iff ((|addr) < 0) $display("Underflow detected");
assert property (~p_underflow);

initial begin
#20 $finish;
end

endmodule