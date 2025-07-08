module seven_seg_display_tb();
    localparam DATA_WIDTH = 4;

    reg [DATA_WIDTH-1:0] data;
    wire [6:0] seg;

    initial begin
        $monitor($time, "Data: %b, Segments: %b", data, seg);

        // Test all possible inputs
        for (int i = 0; i < 16; i++) begin
            data <= i;
            #10;
        end

        // Test edge cases
        data <= 4'h0;
        #10;
        data <= 4'hF;
        #10;
        data <= 4'hA;
        #10;
        data <= 4'h15; // out of range
        #10;
    end

    seven_seg_display dut (
       .data(data),
       .seg(seg)
    );
endmodule