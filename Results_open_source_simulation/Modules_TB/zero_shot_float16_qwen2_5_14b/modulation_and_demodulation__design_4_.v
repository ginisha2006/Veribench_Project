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
        rst = 1; 
        data_in = 0;
        #20 rst = 0;
        
        // Test case 1: All zeros
        data_in = 0;
        #20
        
        // Test case 2: All ones
        data_in = '1;
        #20
        
        // Test case 3: Random pattern
        data_in = $random;
        #20
        
        // Test case 4: Incremental pattern
        for(int i=0; i<DATA_WIDTH; i=i+1) begin
            data_in[i] = 1;
            #20
        end
        
        // Test case 5: Decremental pattern
        for(int i=DATA_WIDTH-1; i>=0; i=i-1) begin
            data_in[i] = 1;
            #20
        end
        
        // Test case 6: Alternating bits
        data_in = 8'h55;
        #20
        
        // Test case 7: Full range
        for(int i=0; i<(2**DATA_WIDTH); i=i+1) begin
            data_in = i;
            #20
        end
        
        $stop;
    end
    
    always @(posedge clk) begin
        $monitor("Time %t | Data In: %b | Modulated Signal: %b | Demodulated Data: %b", $time, data_in, modulated_signal, demodulated_data);
    end
endmodule