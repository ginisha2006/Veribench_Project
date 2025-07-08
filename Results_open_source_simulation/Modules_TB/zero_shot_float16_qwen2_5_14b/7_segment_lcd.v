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

        // Initialize signals
        data = 4'h0;
        #10;

        // Test all valid inputs
        for (int i = 0; i < 16; i++) begin
            data = i;
            #10;
        end

        // Test invalid input
        data = 4'ha;
        #10;
        data = 4'hf;
        #10;
        data = 4'hz; // Invalid value
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
        data = 4'hz; // Invalid again
        #10;

        // Final check with default case
        data = 4'hg;
        #10;

        // Finish simulation
        $finish;
    end

    always @(posedge data) begin
        $display("Data: %h Segments: %b", data, seg);
    end
endmodule