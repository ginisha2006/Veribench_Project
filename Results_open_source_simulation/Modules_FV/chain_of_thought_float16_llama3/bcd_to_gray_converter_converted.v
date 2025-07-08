module tb_bcd_to_gray;
    parameter BCD_WIDTH = 4;
    parameter GRAY_WIDTH = 4;

    logic [BCD_WIDTH-1:0] bcd;
    logic [GRAY_WIDTH-1:0] gray;

    bcd_to_gray dut (
       .bcd(bcd),
       .gray(gray)
    );

    always begin
        #10 clk = ~clk;
    end

    always @(*) begin assert (@(posedge clk) ($rose(clk) |=> $onehot(gray))); end
    always @(*) begin assert (@(posedge clk) ($fell(clk) |=>!($onehot(bcd)))); end
    always @(*) begin assert (@(posedge clk) ($rose(clk) |=> $onehot(gray[GRAY_WIDTH-1]))); end

    always @(*) begin assert (@(posedge clk) ($rose(clk) |=> (bcd == 0) |-> gray == 0); end
        @(posedge clk) ($rose(clk) |=> (bcd == 9) |-> gray == 7));

    always @(*) begin assert (@(posedge clk) ($rose(clk) |=>!($onehot(gray[0])))); end

    always @(*) begin assert (@(posedge clk) ($rose(clk) |=> ((bcd == 8) & (gray!= 6)) |-> false)); end

    logic clk = 0;

endmodule