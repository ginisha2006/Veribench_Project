module reg_file_32bit_tb();

reg clk;
reg rst;
reg we;
wire [4:0] read_addr1;
wire [4:0] read_addr2;
wire [4:0] write_addr;
wire [31:0] write_data;
wire [31:0] read_data1;
wire [31:0] read_data2;

initial begin
    #10 clk = 0;
    forever #(5) clk = ~clk;

    #20 rst = 1;
    #10 rst = 0;

    #100 we = 1;
    write_addr = 3;
    write_data = 32'h12345678;
    #10 we = 0;

    #100 read_addr1 = 1;
    read_addr2 = 2;
    #10;

    $monitor($time, "clk=%b, rst=%b, we=%b, read_addr1=%h, read_addr2=%h, write_addr=%h, write_data=%h, read_data1=%h, read_data2=%h",
           clk, rst, we, read_addr1, read_addr2, write_addr, write_data, read_data1, read_data2);

    #200 $stop;
end

reg_file_32bit uut (
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

endmodule