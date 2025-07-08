module tb_reg_file_32bit (
    input clk,
    input rst,
    input we,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [4:0] write_addr,
    input [31:0] write_data,
    output logic [31:0] read_data1,
    output logic [31:0] read_data2
);

logic [31:0] regs [31:0];

reg_file_32bit dut (
    .clk(clk),
    .rst(rst),
    .we(we),
    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_addr(write_addr),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

always #5 clk = ~clk;

assert (@(posedge rst) disable iff (!rst)
    !rst |-> ##[0:31] foreach(regs[i]) regs[i] == 32'b0);

assert (@(posedge clk) disable iff (!rst && !we)
    we |-> ##1 regs[write_addr] === write_data);

assert (@(posedge clk) disable iff (!rst)
    read_addr1 inside {[0:31]} && read_addr2 inside {[0:31]}
    |-> read_data1 === regs[read_addr1]
       && read_data2 === regs[read_addr2]);

assert (@(posedge clk) disable iff (!rst)
    !we |-> ##1 !$isunknown({regs[*]}));

endmodule