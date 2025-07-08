module mod_demod_tb();
    parameter DATA_WIDTH = 16;
    reg clk;
    reg rst;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] modulated_signal;
    wire [DATA_WIDTH-1:0] demodulated_data;

    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;
        #20 data_in = 16'h0001;
        #40 data_in = 16'hAAAA;
        #60 data_in = 16'hFFFF;
        #80 data_in = 16'h0000;
        repeat(100) begin
            #5 clk = ~clk;
        end
    end

    always @(posedge clk) begin
        if (!rst) begin
            modulated_signal <= 16'h0000;
            demodulated_data <= 16'h0000;
        end else begin
            modulated_signal <= data_in ^ {DATA_WIDTH{1'b1}};
            demodulated_data <= modulated_signal ^ {DATA_WIDTH{1'b1}};
        end
    end

    $monitor($time, "data_in=%h, modulated_signal=%h, demodulated_data=%h", data_in, modulated_signal, demodulated_data);

endmodule