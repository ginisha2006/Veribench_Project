timescale 1ns/10ps

module ram_dual_tb;

reg [7:0] data;
reg [5:0] read_addr, write_addr;
wire [7:0] q;
reg we;
reg clk_r, clk_w;

initial begin
    #100; // delay for setup
    clk_r = 0; clk_w = 0;
    forever begin
        #10 clk_r = ~clk_r;
        #10 clk_w = ~clk_w;
    end
end

initial begin
    $monitor($time, "data: %h, read_addr: %h, write_addr: %h, we: %b, q: %h", 
             data, read_addr, write_addr, we, q);
    
    #50 data = 8'h12; write_addr = 6'b000010; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h34; write_addr = 6'b000011; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h56; write_addr = 6'b000100; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h78; write_addr = 6'b000101; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h90; write_addr = 6'b001000; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'hab; write_addr = 6'b001001; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'hc2; write_addr = 6'b010000; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'hd3; write_addr = 6'b010001; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'he4; write_addr = 6'b100000; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'hf5; write_addr = 6'b100001; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h66; write_addr = 6'b110000; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h77; write_addr = 6'b111000; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h88; write_addr = 6'b111001; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h99; write_addr = 6'b111010; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'haa; write_addr = 6'b111011; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'hbb; write_addr = 6'b111100; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'hcc; write_addr = 6'b111101; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'hdd; write_addr = 6'b111110; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h00; write_addr = 6'b111111; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h11; write_addr = 6'b000000; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h22; write_addr = 6'b000001; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #20 data = 8'h33; write_addr = 6'b000010; we = 1; clk_w = 1; @(posedge clk_w) #10;
    #