module tb_uart;
    reg clk;
    reg rst;
    reg rx;
    wire tx;
    reg [7:0] data_in;
    wire [7:0] data_out;

    initial begin
        clk <= 0;
        forever #5 clk = ~clk; 
    end

    initial begin
        rst <= 1;
        data_in <= 8'b0;
        rx <= 1;
        #10 rst <= 0;
    end

    initial begin
        #100 $finish;
    end

    initial begin
        $dumpfile("uart.vcd");
        $dumpvars(0,tb_uart);
    end

    uart_module uut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .tx(tx),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        @(posedge rst) begin
            data_in <= 8'b10101010;
            rx <= 0;
            @(posedge clk) rx <= 1;
            #100 data_in <= 8'b11110000;
            rx <= 0;
            @(posedge clk) rx <= 1;
            #100 data_in <= 8'b00001111;
            rx <= 0;
            @(posedge clk) rx <= 1;
        end
    end

    always @(posedge clk) begin
        if (!rst && data_out !== 8'bZ) $monitor($time," Data Out: %b", data_out);
    end
endmodule