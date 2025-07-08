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
        end
    end

    initial begin
        $monitor($time," ns Data Out: %b", data_out);
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