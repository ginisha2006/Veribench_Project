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
    #10 clk = 0;
    forever #(5) clk = ~clk;
end

initial begin
    rst = 1;
    #20 rst = 0;
    #10 we = 1;
    write_addr = 5'h10;
    write_data = 32'h12345678;
    #10 we = 0;
    #100;
    read_addr1 = 5'h11;
    read_addr2 = 5'h12;
    #10;
    $display("Expected read data1: %h", expected_read_data1);
    $display("Actual read data1:   %h", read_data1);
    $display("Expected read data2: %h", expected_read_data2);
    $display("Actual read data2:   %h", read_data2);
    $monitor($time, " clk=%b, rst=%b, we=%b, read_addr1=%h, read_addr2=%h, write_addr=%h, write_data=%h, read_data1=%h, read_data2=%h",
             clk, rst, we, read_addr1, read_addr2, write_addr, write_data, read_data1, read_data2);
end

always @(posedge clk) begin
    case ({read_addr1, read_addr2})
        6'h111111: begin
            expected_read_data1 = 32'h12345678;
            expected_read_data2 = 32'h00000000;
        end
        default: begin
            expected_read_data1 = 32'bx;
            expected_read_data2 = 32'bx;
        end
    endcase
end

endmodule