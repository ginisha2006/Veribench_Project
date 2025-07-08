module tb_mod_demod();
    include "mod_demod.sv"
    reg clk;
    reg rst;
    reg [15:0] data_in;
    wire [15:0] modulated_signal;
    wire [15:0] demodulated_data;

    initial begin
        $monitor($time, "clk=%b, rst=%b, data_in=%h, modulated_signal=%h, demodulated_data=%h", clk, rst, data_in, modulated_signal, demodulated_data);

        clk = 0; rst = 1; data_in = 0;
        #10 rst = 0;
        #20 clk = ~clk;
        repeat (100) begin
            #5 clk = ~clk;
        end
        #10 rst = 1;
        #10 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        data_in = 16'h0001;
        @(posedge clk);
        data_in = 16'hAABB;
        @(posedge clk);
        data_in = 16'hFF00;
        @(posedge clk);
        data_in = 16'h0000;
        @(posedge clk);
        data_in = 16'hAAAA;
        @(posedge clk);
        data_in = 16'h5555;
        @(posedge clk);
        data_in = 16'h6666;
        @(posedge clk);
        data_in = 16'h7777;
        @(posedge clk);
        data_in = 16'h8888;
        @(posedge clk);
        data_in = 16'h9999;
        @(posedge clk);
        data_in = 16'hCCCC;
        @(posedge clk);
        data_in = 16'hDDDD;
        @(posedge clk);
        data_in = 16'hEEEE;
        @(posedge clk);
        data_in = 16'hFFFF;
        @(posedge clk);
    end
endmodule