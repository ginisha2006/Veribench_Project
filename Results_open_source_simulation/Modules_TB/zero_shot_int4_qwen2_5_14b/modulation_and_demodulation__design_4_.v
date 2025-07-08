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
        clk <= 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst <= 1; data_in <= 0; #20;
        rst <= 0; data_in <= 8'd17; #20;
        data_in <= 8'd32; #20;
        data_in <= 8'hA5; #20;
        data_in <= 8'hFF; #20;
        data_in <= 8'h00; #20;
        $finish;
    end

    initial begin
        $monitor($time," ns: rst=%b, data_in=%h, modulated_signal=%h, demodulated_data=%h", rst, data_in, modulated_signal, demodulated_data);
    end
endmodule