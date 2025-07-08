module tb_uart;
    reg clk;
    reg rst;
    reg rx;
    wire tx;
    reg [7:0] data_in;
    wire [7:0] data_out;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    initial begin
        rst = 1;
        rx = 1;
        data_in = 8'b0000_0000;
        #10 rst = 0;
        #1000 $finish;
    end

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_uart);
    end

    initial begin
        #100 data_in = 8'b0101_0101;
        rx = 0;
        #100 rx = 1;
        #300 data_in = 8'b1010_1010;
        rx = 0;
        #100 rx = 1;
        #400 data_in = 8'b1111_0000;
        rx = 0;
        #100 rx = 1;
        #500 data_in = 8'b0000_1111;
        rx = 0;
        #100 rx = 1;
        #600 data_in = 8'b1111_1111;
        rx = 0;
        #100 rx = 1;
        #700 data_in = 8'b0000_0000;
        rx = 0;
        #100 rx = 1;
        #800 data_in = 8'b1010_0101;
        rx = 0;
        #100 rx = 1;
        #900 data_in = 8'b0101_1010;
        rx = 0;
        #100 rx = 1;
        #1000 data_in = 8'b1111_1111;
        rx = 0;
        #100 rx = 1;
    end

    initial begin
        #1000 $display("Simulation finished.");
        $stop;
    end

    initial begin
        $monitor("%t Data Out: %b", $time, data_out);
    end

    uart_module uut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .tx(tx),
        .data_in(data_in),
        .data_out(data_out)
    );
endmodule