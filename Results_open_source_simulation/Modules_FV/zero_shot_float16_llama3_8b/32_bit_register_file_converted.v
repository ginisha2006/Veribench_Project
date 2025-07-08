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

always @(*) begin assert (@(posedge clk) disable iff (!rst) ($onehot(regs))); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) ((regs[write_addr] == write_data) |-> (regs[write_addr] === write_data))); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) ((regs[read_addr1] === read_data1) && (regs[read_addr2] === read_data2))); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) (!(|regs) |=> ($onehot(regs)))); end
always @(*) begin assert (@(posedge clk) disable iff (!rst) ((rst |->!regs) && (!rst |->!regs))); end

always #10 clk = ~clk;

initial begin
    clk = 0;
    rst = 1;
    repeat (100) @(posedge clk);
    rst = 0;
    repeat (100) @(posedge clk);
    rst = 1;
    repeat (100) @(posedge clk);
    rst = 0;
    repeat (100) @(posedge clk);
end

endmodule