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

  always #5 clk = ~clk;

  always @(*) begin always @(*) begin assert (@(posedge clk) $rose(we)  ->  (read_addr1 >= 0 && read_addr1 <= 31) && (read_addr2 >= 0 && read_addr2 <= 31)); end end
  always @(*) begin always @(*) begin assert (@(posedge clk) $rose(we) -> (write_addr >= 0 && write_addr <= 31)); end end
  always @(*) begin always @(*) begin assert (@(posedge clk) $rose(we) -> (read_addr1 != write_addr) || (read_addr2 != write_addr)); end end


endmodule