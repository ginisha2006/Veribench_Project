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
        rst <= 1;
        data_in <= 0;
        #5 rst <= 0;
        
        // Test case 1: Normal operation with random data
        for(int i=0; i<10; i++) begin
            data_in <= $random();
            #10;
        end
        
        // Test case 2: Edge case - all zeros
        data_in <= 0;
        #10;
        
        // Test case 3: Edge case - all ones
        data_in <= '1;
        #10;
        
        // Test case 4: Corner case - toggling between zero and one
        for(int i=0; i<10; i++) begin
            data_in <= ~data_in;
            #10;
        end
        
        // Test case 5: Reset condition
        rst <= 1;
        #5 rst <= 0;
        data_in <= $random();
        #10;
        
        $stop;
    end
    
    always #5 clk = ~clk;

    initial begin
        $dumpfile("tb_mod_demod.vcd");
        $dumpvars(0, tb_mod_demod);
    end
    
    initial begin
        $monitor($time, " ns: clk=%b, rst=%b, data_in=%b, modulated_signal=%b, demodulated_data=%b", clk, rst, data_in, modulated_signal, demodulated_data);
    end
endmodule