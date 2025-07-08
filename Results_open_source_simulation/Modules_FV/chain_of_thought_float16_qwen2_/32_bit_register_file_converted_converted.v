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

assert (@(posedge clk) disable iff (!rst)
    rst |-> ##1 foreach(regs[i]) regs[i] == 32'b0);

assert (@(posedge clk) disable iff (!we || !rst)
    we && (write_addr != 5'd31) |-> ##1 read_data1 == write_data & (read_addr1 == write_addr) ||
                                   read_data2 == write_data & (read_addr2 == write_addr));

assert (@(posedge clk) disable iff (!rst)
    read_addr1 inside {[0:31]} |-> read_data1 == regs[read_addr1];
    read_addr2 inside {[0:31]} |-> read_data2 == regs[read_addr2]);

assert (@(posedge clk) disable iff (!rst)
    !(write_addr inside {[0:31]})
    |-> $past(we) && (write_addr > 5'd31 || write_addr < 5'd0) |=> $stable(regs[$anyseq]));

assert (@(posedge clk) disable iff (!rst)
    !$isunknown({clk, rst, we, read_addr1, read_addr2, write_addr, write_data}));

endmodule