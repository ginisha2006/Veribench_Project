module tb_uart;
    reg clk;
    reg rst;
    reg rx;
    wire tx;
    reg [7:0] data_in;
    wire [7:0] data_out;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period is 10 time units
    end

    initial begin
        rst = 1;
        data_in = 8'b0000_0000;
        rx = 1;
        #10 rst = 0;
        #1000 $finish;
    end

    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0, tb_uart);
    end

    initial begin
        @(posedge rst == 0) begin
            data_in = 8'h41; // 'A'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h42; // 'B'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h43; // 'C'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h44; // 'D'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h45; // 'E'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h46; // 'F'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h47; // 'G'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h48; // 'H'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h49; // 'I'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h4a; // 'J'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h4b; // 'K'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h4c; // 'L'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h4d; // 'M'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h4e; // 'N'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h4f; // 'O'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h50; // 'P'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h51; // 'Q'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h52; // 'R'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h53; // 'S'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h54; // 'T'
            rx = 0; // Start bit
            #10 rx = 1; // Stop bit
            #100 data_in = 8'h55; // 'U'
            rx = 0; // Start bit
            #10 rx = 1;