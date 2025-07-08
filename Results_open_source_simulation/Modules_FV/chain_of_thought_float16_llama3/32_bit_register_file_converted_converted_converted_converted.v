module tb_reg_file_32bit;

logic clk;
logic rst;
logic we;
logic [4:0] read_addr1;
logic [4:0] read_addr2;
logic [4:0] write_addr;
logic [31:0] write_data;
logic [31:0] read_data1;
logic [31:0] read_data2;

reg [31:0]regs [31:0];

always @(*) begin always @(*) begin always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!rst) ($onehot(regs))); end end end end
always @(*) begin always @(*) begin always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (!we) (!regs[write_addr])); end end end end
always @(*) begin always @(*) begin always @(*) begin always @(*) begin assert (@(posedge clk) disable iff ((|read_addr1 == |read_addr2)) (regs[read_addr1] === regs[read_addr2])); end end end end
always @(*) begin always @(*) begin always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (we &&!rst) (~regs[write_addr])); end end end end
always @(*) begin always @(*) begin always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (we &&!rst) (regs[write_addr] === write_data)); end end end end
always @(*) begin always @(*) begin always @(*) begin always @(*) begin assert (@(posedge clk) disable iff (we &&!rst) (regs[write_addr]!== write_data)); end end end end
always @(*) begin always @(*) begin always @(*) begin always @(*) begin assert (@(posedge clk) disable iff ((|read_addr1 >= 0) && (|read_addr1 < 32)) (regs[read_addr1][31:0])); end end end end
always @(*) begin always @(*) begin always @(*) begin always @(*) begin assert (@(posedge clk) disable iff ((|write_addr >= 0) && (|write_addr < 32)) (regs[write_addr][31:0])); end end end end
always @(*) begin always @(*) begin always @(*) begin always @(*) begin assert (@(posedge clk) disable iff ((|write_data[31:0])) (regs[write_addr][31:0])); end end end end
always @(*) begin always @(*) begin always @(*) begin always @(*) begin assert (@(posedge clk) disable iff ((|read_data1[31:0]) || (|read_data2[31:0])) (regs[read_addr1][31:0] || regs[read_addr2][31:0])); end end end end

always #10 clk = ~clk;

initial begin
    clk <= 0;
    rst <= 1;
    repeat(100) @(posedge clk);
    rst <= 0;
    repeat(100) @(posedge clk);
    we <= 1;
    write_addr <= 5;
    write_data <= 42;
    repeat(100) @(posedge clk);
    we <= 0;
    repeat(100) @(posedge clk);
    read_addr1 <= 5;
    read_addr2 <= 5;
    repeat(100) @(posedge clk);
end

endmodule