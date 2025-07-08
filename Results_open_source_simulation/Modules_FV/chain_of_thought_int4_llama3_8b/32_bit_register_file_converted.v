module tb_reg_file_32bit;

reg clk;
reg rst;
reg we;
reg [4:0] read_addr1;
reg [4:0] read_addr2;
reg [4:0] write_addr;
reg [31:0] write_data;
wire [31:0] read_data1;
wire [31:0] read_data2;

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

always @(*) begin assert (!rst |=> ($onehot(regs))); end
always @(*) begin assert ((we &&!rst) |=> (regs[write_addr] == write_data)); end
always @(*) begin assert ((!we &&!rst) |=> ((regs[read_addr1] == read_data1) && (regs[read_addr2] == read_data2))); end
always @(*) begin assert ((posedge clk) |=> (!rst || we)); end
always @(*) begin assert ((write_addr >= 32'd31) |=> ($error("Write address overflow")); end
    (read_addr1 >= 32'd31) |=> ($error("Read address 1 overflow"));
    (read_addr2 >= 32'd31) |=> ($error("Read address 2 overflow")));
always @(*) begin assert ((!rst &&!we && read_addr1!= read_addr2) |=> ($error("Illegal transition between read addresses"))); end

endmodule