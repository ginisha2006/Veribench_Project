module tb_bcd_to_gray;
    parameter BCD_WIDTH = 4;
    parameter GRAY_WIDTH = 4;

    logic [BCD_WIDTH-1:0] bcd;
    logic [GRAY_WIDTH-1:0] gray;

    bcd_to_gray #(BCD_WIDTH, GRAY_WIDTH) dut (
       .bcd(bcd),
       .gray(gray)
    );

    always begin
        #10 clk = ~clk;
    end

    always @(*) begin assert (@(posedge clk) disable iff (!rst_n) ($onehot(bcd))); end
    always @(*) begin assert (@(posedge clk) disable iff (!rst_n) (!$onehot(bcd))); end
    always @(*) begin assert (@(posedge clk) disable iff (!rst_n) ((bcd == 0) => (gray == 0)); end
        @(posedge clk) disable iff (!rst_n) ((bcd == 1) => (gray == 1));
        @(posedge clk) disable iff (!rst_n) ((bcd == 2) => (gray == 3));
        @(posedge clk) disable iff (!rst_n) ((bcd == 3) => (gray == 7));
        @(posedge clk) disable iff (!rst_n) ((bcd == 4) => (gray == 0));
        @(posedge clk) disable iff (!rst_n) ((bcd == 5) => (gray == 1));
        @(posedge clk) disable iff (!rst_n) ((bcd == 6) => (gray == 3));
        @(posedge clk) disable iff (!rst_n) ((bcd == 7) => (gray == 7));
        @(posedge clk) disable iff (!rst_n) ((bcd == 8) => (gray == 0));
        @(posedge clk) disable iff (!rst_n) ((bcd == 9) => (gray == 1));
        @(posedge clk) disable iff (!rst_n) ((bcd == 10) => (gray == 3));
        @(posedge clk) disable iff (!rst_n) ((bcd == 11) => (gray == 7));
        @(posedge clk) disable iff (!rst_n) ((bcd == 12) => (gray == 0));
        @(posedge clk) disable iff (!rst_n) ((bcd == 13) => (gray == 1));
        @(posedge clk) disable iff (!rst_n) ((bcd == 14) => (gray == 3));
        @(posedge clk) disable iff (!rst_n) ((bcd == 15) => (gray == 7)));
    always @(*) begin assert (@(posedge clk) disable iff (!rst_n) ((bcd >= 16) | (bcd < 0))); end
    always @(*) begin assert (@(posedge clk) disable iff (!rst_n) ((bcd > 15) & (bcd < 16))); end

    logic rst_n;
    logic clk;

    initial begin
        rst_n = 1'b1;
        clk = 1'b0;
        #20 rst_n = 1'b0;
        #10 rst_n = 1'b1;
    end
endmodule