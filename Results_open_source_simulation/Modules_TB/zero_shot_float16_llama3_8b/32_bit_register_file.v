module reg_file_32bit_tb;

reg clk;
reg rst;
reg we;
wire [4:0] read_addr1;
wire [4:0] read_addr2;
wire [4:0] write_addr;
wire [31:0] write_data;
wire [31:0] read_data1;
wire [31:0] read_data2;

reg [31:0] expected_read_data1;
reg [31:0] expected_read_data2;

initial begin
    #100 clk = 0;
    forever #(50) clk = ~clk;
end

initial begin
    rst = 1;
    #20 rst = 0;
    #100 we = 1;
    write_addr = 5'h10;
    write_data = 32'h12345678;
    #10 we = 0;
    #100 read_addr1 = 5'h11;
    #10 read_addr2 = 5'h12;
    #100 $display("Expected read data1: %h", expected_read_data1);
    #10 $display("Actual read data1: %h", read_data1);
    #100 $display("Expected read data2: %h", expected_read_data2);
    #10 $display("Actual read data2: %h", read_data2);
    #100 $finish;
end

always @(posedge clk) begin
    if (rst) begin
        expected_read_data1 = 32'h00000000;
        expected_read_data2 = 32'h00000000;
    end else if (we && write_addr == 5'h10) begin
        expected_read_data1 = 32'h12345678;
        expected_read_data2 = 32'h00000000;
    end
end

$monitor($time, "clk=%b, rst=%b, we=%b, read_addr1=%h, read_addr2=%h, write_addr=%h, write_data=%h, read_data1=%h, read_data2=%h");

endmodule