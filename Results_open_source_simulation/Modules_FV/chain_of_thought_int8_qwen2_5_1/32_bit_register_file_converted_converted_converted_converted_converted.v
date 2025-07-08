module tb_reg_file_32bit (
    input clk,
    input rst,
    input we,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);

reg [31:0] regs [31:0];

assert (@(posedge clk) disable iff (!rst)
    (rst |-> ##1 foreach(regs[i]) regs[i] == 32'b0));

assert (@(posedge clk) disable iff (!we)
    (we & (write_addr < 32) |-> ##1 regs[write_addr] == write_data));

assert (@(posedge clk) disable iff (!rst)
    (read_addr1 < 32 |-> read_data1 == regs[read_addr1]));

assert (@(posedge clk) disable iff (!rst)
    (read_addr2 < 32 |-> read_data2 == regs[read_addr2]));

assert (@(posedge clk) disable iff (!rst)
    (!(read_addr1 < 32) |-> read_data1 === 32'bX));

assert (@(posedge clk) disable iff (!rst)
    (!(read_addr2 < 32) |-> read_data2 === 32'bX));

assert (@(posedge clk) disable iff (!rst)
    (!(write_addr < 32) |-> !we));

endmodule