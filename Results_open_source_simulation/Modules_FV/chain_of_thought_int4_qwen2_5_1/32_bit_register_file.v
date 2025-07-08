module tb_reg_file_32bit (
    input clk,
    input rst,
    input we,
    input [4:0] read_addr1,
    input [4:0] read_addr2,
    input [4:5] write_addr,
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);

reg [31:0] regs [31:0];

always #1 clk = ~clk;

property reset_behavior;
    @(posedge rst) disable iff (!rst)
    ($stable(rst)) |-> (foreach(regs[i]) regs[i] == 32'b0);
endproperty
assert property(reset_behavior);

property write_enable;
    @(posedge clk) disable iff (!rst)
    we ##1 -> (regs[write_addr] === write_data);
endproperty
assert property(write_enable);

property read_address_valid;
    @(posedge clk) disable iff (!rst)
    (read_addr1 inside {[0:31]} && read_addr2 inside {[0:31]})
    |->
    (read_data1 === regs[read_addr1] &&
     read_data2 === regs[read_addr2]);
endproperty
assert property(read_address_valid);

property no_write_on_reset;
    @(posedge clk) disable iff (!rst)
    rst ##1 -> !we;
endproperty
assert property(no_write_on_reset);

endmodule