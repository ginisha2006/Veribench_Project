module mod_demod_tb();
    localparam DATA_WIDTH = 16;
    reg clk;
    reg rst;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] modulated_signal;
    wire [DATA_WIDTH-1:0] demodulated_data;

    initial begin
        #10 clk = 1; rst = 1; data_in = 0; @(posedge clk) rst = 0;
        #1000 repeat(10) begin
            data_in = $random % (1 << DATA_WIDTH); // random data generation
            #10;
            $display("Data In: %h", data_in);
            $display("Modulated Signal: %h", modulated_signal);
            $display("Demodulated Data: %h", demodulated_data);
        end
    end

    always #5 clk = ~clk; // clock generation

    initial begin
        $monitor("Time: %t\nData In: %b\nModulated Signal: %b\nDemodulated Data: %b\n",
                $time, data_in, modulated_signal, demodulated_data);
    end
endmodule