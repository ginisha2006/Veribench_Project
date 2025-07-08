module tb_reg_file_32bit();

parameter CLOCK_PERIOD = 10;

reg clk;

reg rst;

reg [4:0] read_addr1;

reg [4:0] read_addr2;

reg [4:0] write_addr;

reg [31:0] write_data;

wire [31:0] read_data1;

wire [31:0] read_data2;

reg_file_32bit dut (.clk(clk),.rst(rst),.we(write_we),.read_addr1(read_addr1),.read_addr2(read_addr2),.write_addr(write_addr),.write_data(write_data),.read_data1(read_data1),.read_data2(read_data2));

always #CLOCK_PERIOD clk = ~clk;

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!rst) ($onehot(write_addr) && write_addr < 32)); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!rst) ($onehot(read_addr1) && read_addr1 < 32) | ($onehot(read_addr2) && read_addr2 < 32)); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!rst) ($size(write_data) == 32)); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!rst) ($size(read_data1) == 32) | ($size(read_data2) == 32)); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!rst) (~|($onehot(read_addr1) & read_addr1 >= 32) | (~|($onehot(read_addr2) & read_addr2 >= 32))); end end

always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!rst) (~|($onehot(write_addr) & write_addr > 31))); end end

endmodule