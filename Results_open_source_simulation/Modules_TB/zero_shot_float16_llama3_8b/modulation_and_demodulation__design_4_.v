module mod_demod_tb();
    parameter DATA_WIDTH = 16;
    reg clk;
    reg rst;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] modulated_signal;
    wire [DATA_WIDTH-1:0] demodulated_data;

    initial begin
        #10 clk = 1; rst = 1;
        #20 rst = 0;
        #100 $monitor($time, "data_in=%h, modulated_signal=%h, demodulated_data=%h", data_in, modulated_signal, demodulated_data);
        repeat(5) begin
            #50 data_in = $random();
            #100;
        end
    end

    always #10 clk = ~clk;

    initial begin
        #100 $display("Simulation complete");
    end

    mod_demod uut (
       .clk(clk),
       .rst(rst),
       .data_in(data_in),
       .modulated_signal(modulated_signal),
       .demodulated_data(demodulated_data)
    );
endmodule