module seven_seg_display_tb;

parameter DATA_WIDTH = 4;
reg [DATA_WIDTH-1:0] data;
wire [6:0] seg;

initial begin
    $monitor($time, "Data: %b, Segments: %b", data, seg);

    // Test all possible inputs
    for (int i = 0; i < 16; i++) begin
        data <= i;
        #10;
    end

    // Test some specific inputs
    data <= 4'h4;
    #10;
    data <= 4'hF;
    #10;
    data <= 4'h8;
    #10;
    data <= 4'hA;
    #10;
    data <= 4'hC;
    #10;
    data <= 4'hE;
    #10;
    data <= 4'h0;
    #10;
    data <= 4'h1;
    #10;
    data <= 4'h3;
    #10;
    data <= 4'h5;
    #10;
    data <= 4'h6;
    #10;
    data <= 4'h7;
    #10;
    data <= 4'h9;
    #10;
    data <= 4'hB;
    #10;
    data <= 4'hD;
    #10;
    data <= 4'hF;
    #10;
    $finish;
end
endmodule