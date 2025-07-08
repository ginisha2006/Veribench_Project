module tb_uart;
    reg clk;
    reg rst;
    reg rx;
    wire tx;
    reg [7:0] data_in;
    wire [7:0] data_out;

    uart_module uut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .tx(tx),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        clk <= 0; 
        rst <= 1;
        rx <= 0;
        data_in <= 8'b0;
        #10 rst <= 0;
    end

    always #5 clk = ~clk;

    initial begin
        @(negedge rst) begin
            data_in <= 8'b01010101;
            rx <= 1;
            #10 rx <= 0;
            #300;
            data_in <= 8'b10101010;
            rx <= 1;
            #10 rx <= 0;
            #300;
            data_in <= 8'b11110000;
            rx <= 1;
            #10 rx <= 0;
            #300;
            $finish;
        end
    end

    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0,tb_uart);
    end

    initial begin
        $monitor($time," ns: tx=%b, data_out=%b", tx, data_out);
    end
endmodule