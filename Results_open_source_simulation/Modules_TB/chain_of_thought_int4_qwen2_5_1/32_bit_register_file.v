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

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        we = 0;
        read_addr1 = 5'd0;
        read_addr2 = 5'd0;
        write_addr = 5'd0;
        write_data = 32'd0;
        #10 rst = 0;
        #10 we = 1;
        write_addr = 5'd1;
        write_data = 32'd42;
        #10 we = 0;
        read_addr1 = 5'd1;
        read_addr2 = 5'd1;
        #10 read_addr1 = 5'd2;
        read_addr2 = 5'd2;
        #10 we = 1;
        write_addr = 5'd2;
        write_data = 32'd84;
        #10 we = 0;
        read_addr1 = 5'd2;
        read_addr2 = 5'd2;
        #10 we = 1;
        write_addr = 5'd3;
        write_data = 32'd168;
        #10 we = 0;
        read_addr1 = 5'd3;
        read_addr2 = 5'd3;
        #10 we = 1;
        write_addr = 5'd4;
        write_data = 32'd336;
        #10 we = 0;
        read_addr1 = 5'd4;
        read_addr2 = 5'd4;
        #10 $finish;
    end

    initial begin
        $dumpfile("reg_file.vcd");
        $dumpvars(0, tb_reg_file_32bit);
    end

    initial begin
        $monitor($time, " ns: read_data1=%b, read_data2=%b", read_data1, read_data2);
    end
endmodule