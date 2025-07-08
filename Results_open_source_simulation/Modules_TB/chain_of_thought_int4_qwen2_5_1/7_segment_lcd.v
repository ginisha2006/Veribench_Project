module tb_seven_seg_display;
    parameter DATA_WIDTH = 4;

    reg [DATA_WIDTH-1:0] data;
    wire [6:0] seg;

    seven_seg_display #(.DATA_WIDTH(DATA_WIDTH)) uut (
        .data(data),
        .seg(seg)
    );

    initial begin
        // Initialize signals
        data = 4'h0;
        #10;
        
        // Test all valid inputs
        for(int i=0; i<16; i++) begin
            data = i;
            #10;
        end
        
        // Test invalid input
        data = 4'ha;
        #10;
        
        // Edge case - max value
        data = 4'hf;
        #10;
        
        // Edge case - min value
        data = 4'h0;
        #10;
        
        // Corner case - random values
        data = 4'hb;
        #10;
        data = 4'hc;
        #10;
        data = 4'hd;
        #10;
        data = 4'he;
        #10;
        data = 4'hf;
        #10;
        
        // Default case
        data = 4'hg;
        #10;
        
        // Final check with default value
        data = 4'hz;
        #10;
        
        // End simulation
        $finish;
    end
    
    // Monitor outputs
    initial begin
        $monitor($time, " ns: data=%h, seg=%b", data, seg);
    end
endmodule