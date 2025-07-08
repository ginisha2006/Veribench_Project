module tb_reg_file_32bit();

reg clk;
reg rst;
reg we;
reg [4:0] read_addr1;
reg [4:0] read_addr2;
reg [31:0] write_data;
wire [31:0] read_data1;
wire [31:0] read_data2;

integer i;

initial begin
    #10 clk = 0;
    forever #(5) clk = ~clk;
end

initial begin
    rst = 1;
    repeat(10) @(posedge clk);
    rst = 0;
    repeat(10) @(posedge clk);

    write_data = 32'h00000001;
    we = 1;
    read_addr1 = 5'h00;
    read_addr2 = 5'h00;
    @(posedge clk);
    we = 0;

    write_data = 32'h00000002;
    write_addr = 5'h01;
    @(posedge clk);

    write_data = 32'h00000003;
    write_addr = 5'h02;
    @(posedge clk);

    read_addr1 = 5'h00;
    read_addr2 = 5'h01;
    @(posedge clk);
    $monitor($time, "read_data1: %h, read_data2: %h", read_data1, read_data2);
end

endmodule