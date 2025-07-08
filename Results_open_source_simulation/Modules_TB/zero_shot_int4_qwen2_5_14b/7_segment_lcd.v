module tb_seven_seg_display;
    reg [3:0] data;
    wire [6:0] seg;

    seven_seg_display uut (
        .data(data),
        .seg(seg)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_seven_seg_display);

        // Test all possible inputs
        for (integer i=0; i<16; i=i+1) begin
            data = i;
            #(10)
        end
        
        // Edge case - out-of-range value
        data = 4'hG;
        #(10)

        // Corner case - minimum value
        data = 4'h0;
        #(10)

        // Corner case - maximum value
        data = 4'hF;
        #(10)

        // Random values
        data = 4'h3;
        #(10)
        data = 4'hA;
        #(10)
        data = 4'h5;
        #(10)

        $finish;
    end
    
    initial begin
        $monitor($time, " ns: data=%b seg=%b", data, seg);
    end
endmodule