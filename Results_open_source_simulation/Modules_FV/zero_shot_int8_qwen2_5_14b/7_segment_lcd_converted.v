module tb_seven_seg_display();
    parameter DATA_WIDTH = 4;
    
    logic [DATA_WIDTH-1:0] data;
    logic [6:0] seg;

    seven_seg_display dut (
        .data(data),
        .seg(seg)
    );

    // Clock generation
    logic clk;
    always #(5ns) clk = ~clk;

    // Functional correctness assertions
    always @(*) begin assert (@(posedge clk) data == 4'h0 |-> seg == 7'b1000000); end

    always @(*) begin assert (@(posedge clk) data == 4'h1 |-> seg == 7'b1111001); end

    always @(*) begin assert (@(posedge clk) data == 4'h2 |-> seg == 7'b0100100); end

    always @(*) begin assert (@(posedge clk) data == 4'h3 |-> seg == 7'b0110000); end

    always @(*) begin assert (@(posedge clk) data == 4'h4 |-> seg == 7'b0011001); end

    always @(*) begin assert (@(posedge clk) data == 4'h5 |-> seg == 7'b0010010); end

    always @(*) begin assert (@(posedge clk) data == 4'h6 |-> seg == 7'b0000010); end

    always @(*) begin assert (@(posedge clk) data == 4'h7 |-> seg == 7'b1111000); end

    always @(*) begin assert (@(posedge clk) data == 4'h8 |-> seg == 7'b0000000); end

    always @(*) begin assert (@(posedge clk) data == 4'h9 |-> seg == 7'b0011000); end

    always @(*) begin assert (@(posedge clk) data == 4'hA |-> seg == 7'b0001000); end

    always @(*) begin assert (@(posedge clk) data == 4'hB |-> seg == 7'b0000011); end

    always @(*) begin assert (@(posedge clk) data == 4'hC |-> seg == 7'b1000110); end

    always @(*) begin assert (@(posedge clk) data == 4'hD |-> seg == 7'b0100001); end

    always @(*) begin assert (@(posedge clk) data == 4'hE |-> seg == 7'b0000110); end

    always @(*) begin assert (@(posedge clk) data == 4'hF |-> seg == 7'b0001110); end

    always @(*) begin assert (@(posedge clk) data != 4'h0 && data != 4'h1 && data != 4'h2 && data != 4'h3 && data != 4'h4 && data != 4'h5 && data != 4'h6 && data != 4'h7 && data != 4'h8 && data != 4'h9 && data != 4'hA && data != 4'hB && data != 4'hC && data != 4'hD && data != 4'hE && data != 4'hF |-> seg == 7'b1111111); end

endmodule