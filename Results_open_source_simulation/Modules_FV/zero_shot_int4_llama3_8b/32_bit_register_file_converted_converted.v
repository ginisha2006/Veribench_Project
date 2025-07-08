module tb_reg_file_32bit;

parameter PERIOD = 10;

logic clk;
logic rst;
logic we;
logic [4:0] read_addr1;
logic [4:0] read_addr2;
logic [31:0] write_data;
logic [31:0] read_data1;
logic [31:0] read_data2;

reg_file_32bit dut (
   .clk(clk),
   .rst(rst),
   .we(we),
   .read_addr1(read_addr1),
   .read_addr2(read_addr2),
   .write_addr(write_data[4:0]),
   .write_data(write_data),
   .read_data1(read_data1),
   .read_data2(read_data2)
);

assert property p_all_properties;

always #PERIOD clk = ~clk;

initial begin
    clk <= 0;
    rst <= 1;
    repeat (100) @(posedge clk);
    rst <= 0;
    repeat (100) @(posedge clk);
    rst <= 1;
    repeat (100) @(posedge clk);
    rst <= 0;
    repeat (100) @(posedge clk);
    clk <= 0;
    $finish;
end

endmodule