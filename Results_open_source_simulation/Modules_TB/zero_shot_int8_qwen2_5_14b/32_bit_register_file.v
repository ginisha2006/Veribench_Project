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
        
        // Write data to address 0
        we = 1;
        write_addr = 5'd0;
        write_data = 32'hDEADBEEF;
        #10 we = 0;
        
        // Read from address 0
        read_addr1 = 5'd0;
        #10
        
        // Write data to address 1
        we = 1;
        write_addr = 5'd1;
        write_data = 32'hCAFEBABE;
        #10 we = 0;
        
        // Read from address 1
        read_addr1 = 5'd1;
        #10
        
        // Read from different addresses simultaneously
        read_addr1 = 5'd0;
        read_addr2 = 5'd1;
        #10
        
        // Edge case - reset during write operation
        we = 1;
        write_addr = 5'd2;
        write_data = 32'hBADDCAFE;
        #5 rst = 1;
        #5 rst = 0;
        we = 0;
        
        // Corner case - writing beyond register range
        we = 1;
        write_addr = 5'd31;
        write_data = 32'hFACEBEEF;
        #10 we = 0;
        
        // Reading beyond register range
        read_addr1 = 5'd31;
        #10
        
        // Final check after reset
        rst = 1;
        #10 rst = 0;
        #10
        
        $stop;
    end
    
    initial begin
        $monitor($time," ns | read_data1 = %h, read_data2 = %h", read_data1, read_data2);
    end
endmodule