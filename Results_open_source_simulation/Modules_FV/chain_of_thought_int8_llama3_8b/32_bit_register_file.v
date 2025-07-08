module tb_reg_file_32bit();

input clk;

input rst;

input we;

input [4:0] read_addr1;

input [4:0] read_addr2;

input [4:0] write_addr;

input [31:0] write_data;

output [31:0] read_data1;

output [31:0] read_data2;

reg [31:0] regs [31:0];

integer i;

property p_reset_all_zeros;

@ (posedge clk) disable iff (!rst)

$rose(rst) |=> ($onehot(regs));

endproperty

property p_write_correct;

@ (posedge clk) disable iff (!rst)

($fell(clk) |-> ($stable(we)) |=> (regs[write_addr] == write_data);

endproperty

property p_read_correct;

@ (posedge clk) disable iff (!rst)

($fell(clk) |-> ($stable(read_addr1)) |=> (read_data1 == regs[read_addr1]);

($fell(clk) |-> ($stable(read_addr2)) |=> (read_data2 == regs[read_addr2]);

endproperty

property p_no_write_on_rst;

@ (posedge clk) disable iff (!rst)

$rose(rst) |=> (!$we);

endproperty

property p_no_write_on_read;

@ (posedge clk) disable iff (!rst)

($fell(clk) & $stable(we) & $stable(read_addr1) & $stable(read_addr2)) |=> (!$we);

endproperty

property p_no_write_on_same_addr;

@ (posedge clk) disable iff (!rst)

($fell(clk) & $stable(we) & $stable(write_addr) & ($stable(read_addr1) | $stable(read_addr2))) |=> (!$we);

endproperty

assert property (p_reset_all_zeros);

assert property (p_write_correct);

assert property (p_read_correct);

assert property (p_no_write_on_rst);

assert property (p_no_write_on_read);

assert property (p_no_write_on_same_addr);

endmodule