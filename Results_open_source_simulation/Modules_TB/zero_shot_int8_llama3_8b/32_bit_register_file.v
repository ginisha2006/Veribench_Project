module tb_reg_file_32bit;

reg clk;
reg rst;
reg we;
wire [4:0] read_addr1;
wire [4:0] read_addr2;
wire [4:0] write_addr;
wire [31:0] write_data;
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

initial begin
    #100 clk = 1; rst = 1; we = 0; read_addr1 = 5'h00; read_addr2 = 5'h01; write_addr = 5'h02; write_data = 32'h00000001;
    #200 clk = 0; rst = 0; we = 0; read_addr1 = 5'h03; read_addr2 = 5'h04;
    #200 clk = 1; rst = 0; we = 1; write_addr = 5'h05; write_data = 32'h00000002;
    #400 clk = 0; we = 0;
    #200 clk = 1; rst = 1; we = 0; read_addr1 = 5'h00; read_addr2 = 5'h01;
    #200 $display("Expected read_data1: %h, Actual read_data1: %h", 32'h00000001, read_data1);
    #200 $display("Expected read_data2: %h, Actual read_data2: %h", 32'h00000002, read_data2);
    #1000 $finish;
end

always #5 clk =~ clk;

$monitor($time, "clk:%b, rst:%b, we:%b, read_addr1:%h, read_addr2:%h, write_addr:%h, write_data:%h, read_data1:%h, read_data2:%h",
         clk, rst, we, read_addr1, read_addr2, write_addr, write_data, read_data1, read_data2);

endmodule