timescale 1ns / 1ps
module tb_mod_demod;
    parameter DATA_WIDTH = 16;
    reg clk;
    reg rst;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] modulated_signal;
    wire [DATA_WIDTH-1:0] demodulated_data;

    mod_demod #(.DATA_WIDTH(DATA_WIDTH)) uut (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .modulated_signal(modulated_signal),
        .demodulated_data(demodulated_data)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1; data_in = 0; #10;
        rst = 0; data_in = 8'd10; #10;
        data_in = 8'd20; #10;
        data_in = 8'hF0; #10;
        data_in = 8'hFF; #10;
        data_in = 8'h00; #10;
        data_in = 8'hFE; #10;
        data_in = 8'hFD; #10;
        data_in = 8'hFC; #10;
        data_in = 8'hFB; #10;
        data_in = 8'hFA; #10;
        data_in = 8'h01; #10;
        data_in = 8'h02; #10;
        data_in = 8'h03; #10;
        data_in = 8'h04; #10;
        data_in = 8'h05; #10;
        data_in = 8'h06; #10;
        data_in = 8'h07; #10;
        data_in = 8'h08; #10;
        data_in = 8'h09; #10;
        data_in = 8'h0A; #10;
        data_in = 8'h0B; #10;
        data_in = 8'h0C; #10;
        data_in = 8'h0D; #10;
        data_in = 8'h0E; #10;
        data_in = 8'h0F; #10;
        data_in = 8'h10; #10;
        data_in = 8'h11; #10;
        data_in = 8'h12; #10;
        data_in = 8'h13; #10;
        data_in = 8'h14; #10;
        data_in = 8'h15; #10;
        data_in = 8'h16; #10;
        data_in = 8'h17; #10;
        data_in = 8'h18; #10;
        data_in = 8'h19; #10;
        data_in = 8'h1A; #10;
        data_in = 8'h1B; #10;
        data_in = 8'h1C; #10;
        data_in = 8'h1D; #10;
        data_in = 8'h1E; #10;
        data_in = 8'h1F; #10;
        data_in = 8'h20; #10;
        data_in = 8'h21; #10;
        data_in = 8'h22; #10;
        data_in = 8'h23; #10;
        data_in = 8'h24; #10;
        data_in = 8'h25; #10;
        data_in = 8'h26; #10;
        data_in = 8'h27; #10;
        data_in = 8'h28; #10;
        data_in = 8'h29; #10;
        data_in = 8'h2A; #10;
        data_in = 8'h2B; #10;
        data_in = 8'h2C; #10;
        data_in = 8'h2D; #10;
        data_in = 8'h2E; #10;
        data_in = 8'h2F; #10;
        data_in = 8'h30; #10;
        data_in = 8'h31; #10;
        data_in = 8'h32; #10;
        data_in = 8'h