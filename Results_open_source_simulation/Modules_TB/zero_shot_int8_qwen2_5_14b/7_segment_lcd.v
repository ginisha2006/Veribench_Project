module tb_seven_seg_display;
    reg [3:0] data;
    wire [6:0] seg;

    seven_seg_display uut (
        .data(data),
        .seg(seg)
    );

    initial begin
        // Initialize signals
        data = 4'h0;
        #10 $display("Data: %b Segments: %b", data, seg);

        // Test all valid inputs
        for (integer i = 0; i < 16; i++) begin
            data = i;
            #10 $display("Data: %b Segments: %b", data, seg);
        end

        // Test invalid input
        data = 4'ha;
        #10 $display("Data: %b Segments: %b", data, seg);

        // Test boundary conditions
        data = 4'hf;
        #10 $display("Data: %b Segments: %b", data, seg);

        // Edge case - max value + 1
        data = 4'hg;
        #10 $display("Data: %b Segments: %b", data, seg);

        // Finish simulation
        $finish;
    end
endmodule