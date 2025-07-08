module seven_seg_display_tb;

parameter DATA_WIDTH = 4;

reg [DATA_WIDTH-1:0] data;
wire [6:0] seg;

seven_seg_display uut (
   .data(data),
   .seg(seg)
);

initial begin
    $monitor($time, "Data: %b, Segments: %b", data, seg);

    // Test all possible inputs
    for (int i = 0; i < 16; i++) begin
        data <= i;
        #10;
    end

    // Test invalid input
    data <= 15;
    #10;
    data <= 16;
    #10;

    $finish;
end

endmodule