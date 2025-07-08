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
        forever #5 clk = ~clk; // 100MHz clock
    end

    initial begin
        rst <= 1;
        data_in <= 0;
        #20 rst <= 0;
        
        for(int i=0; i<10; i=i+1) begin
            data_in <= i*16'hFFFF;
            #10;
        end
        
        for(int j=-8; j<=8; j=j+1) begin
            data_in <= j;
            #10;
        end
        
        #20 $finish;
    end
    
    initial begin
        $dumpfile("tb_mod_demod.vcd");
        $dumpvars(0, tb_mod_demod);
    end
    
    initial begin
        $monitor($time," ns: data_in=%h, modulated_signal=%h, demodulated_data=%h", data_in, modulated_signal, demodulated_data);
    end
endmodule