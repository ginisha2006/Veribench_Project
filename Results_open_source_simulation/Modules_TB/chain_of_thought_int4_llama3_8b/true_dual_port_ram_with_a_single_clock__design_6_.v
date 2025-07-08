timescale 1ns / 100ps

module tb_true_dpram_sclk;

parameter CLOCK_PERIOD = 10; // in ns

reg clk;
reg [7:0] data_a, data_b;
reg [5:0] addr_a, addr_b;
reg we_a, we_b;

wire [7:0] q_a, q_b;

initial begin
    #500 $display("Starting simulation...");
    forever begin
        #CLOCK_PERIOD clk = ~clk;
    end
end

initial begin
    #50 data_a = 8'h12;
    #20 addr_a = 6'h00;
    #20 we_a = 1'b1;
    #20 we_a = 1'b0;
    
    #50 data_b = 8'h34;
    #20 addr_b = 6'h01;
    #20 we_b = 1'b1;
    #20 we_b = 1'b0;
    
    #50 data_a = 8'h56;
    #20 addr_a = 6'h02;
    #20 we_a = 1'b1;
    #20 we_a = 1'b0;
    
    #50 data_b = 8'h78;
    #20 addr_b = 6'h03;
    #20 we_b = 1'b1;
    #20 we_b = 1'b0;
    
    #50 data_a = 8'h90;
    #20 addr_a = 6'h04;
    #20 we_a = 1'b1;
    #20 we_a = 1'b0;
    
    #50 data_b = 8'hAB;
    #20 addr_b = 6'h05;
    #20 we_b = 1'b1;
    #20 we_b = 1'b0;
    
    #50 data_a = 8'hCD;
    #20 addr_a = 6'h06;
    #20 we_a = 1'b1;
    #20 we_a = 1'b0;
    
    #50 data_b = 8'hEF;
    #20 addr_b = 6'h07;
    #20 we_b = 1'b1;
    #20 we_b = 1'b0;
    
    #50 data_a = 8'h00;
    #20 addr_a = 6'h08;
    #20 we_a = 1'b1;
    #20 we_a = 1'b0;
    
    #50 data_b = 8'h11;
    #20 addr_b = 6'h09;
    #20 we_b = 1'b1;
    #20 we_b = 1'b0;
    
    #50 data_a = 8'h22;
    #20 addr_a = 6'h10;
    #20 we_a = 1'b1;
    #20 we_a = 1'b0;
    
    #50 data_b = 8'h33;
    #20 addr_b = 6'h11;
    #20 we_b = 1'b1;
    #20 we_b = 1'b0;
    
    #50 data_a = 8'h44;
    #20 addr_a = 6'h12;
    #20 we_a = 1'b1;
    #20 we_a = 1'b0;
    
    #50 data_b = 8'h55;
    #20 addr_b = 6'h13;
    #20 we_b = 1'b1;
    #20 we_b = 1'b0;
    
    #50 data_a = 8'h66;
    #20 addr_a = 6'h14;
    #20 we_a = 1'b1;
    #20 we_a = 1'b0;
    
    #50 data_b = 8'h77;
    #20 addr_b = 6'h15;
    #20 we_b = 1'b1;
    #20 we_b = 1'b0;
    
    #50 data_a = 8'h88;
    #20 addr_a = 6'h16;
    #20 we_a = 1'b1;
    #20 we_a = 1'b0;
    
    #50 data_b = 8'h99;
    #20 addr_b = 6'h17;
    #20 we_b = 1'b1;
    #20 we_b = 1'b0;
    
    #50 data_a = 8'hAA;
    #20 addr_a = 6'h18;
    #20 we_a = 1'b1;
    #20 we_a = 1'b0;
    
    #50 data_b = 8'hBB;
    #20 addr_b = 6'h19;
    #20 we_b = 1'b1;
    #20 we_b = 1'b0;
    
    #50 data_a = 8'hCC;
    #