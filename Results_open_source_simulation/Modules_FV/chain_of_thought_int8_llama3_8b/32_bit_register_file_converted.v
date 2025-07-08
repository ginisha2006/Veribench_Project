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

assert (@ (posedge clk) disable iff (!rst)

$rose(rst) |=> ($onehot(regs)));

assert (@ (posedge clk) disable iff (!rst)

($fell(clk) |-> ($stable(we)) |=> (regs[write_addr] == write_data));

assert (@ (posedge clk) disable iff (!rst)

($fell(clk) |-> ($stable(read_addr1)) |=> (read_data1 == regs[read_addr1]);

($fell(clk) |-> ($stable(read_addr2)) |=> (read_data2 == regs[read_addr2]));

assert (@ (posedge clk) disable iff (!rst)

$rose(rst) |=> (!$we));

assert (@ (posedge clk) disable iff (!rst)

($fell(clk) & $stable(we) & $stable(read_addr1) & $stable(read_addr2)) |=> (!$we));

assert (@ (posedge clk) disable iff (!rst)

($fell(clk) & $stable(we) & $stable(write_addr) & ($stable(read_addr1) | $stable(read_addr2))) |=> (!$we));

endmodule