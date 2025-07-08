module tb_param_shift_reg;
    parameter WIDTH = 8;
    reg clk;
    reg rst;
    reg load;
    reg [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] data_out;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock generation
    end

    param_shift_reg uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        $monitor($time," ns: clk=%b, rst=%b, load=%b, data_in=%d, data_out=%d", clk, rst, load, data_in, data_out);

        rst = 1; load = 0; data_in = 8'b10101010; #10;
        rst = 0; load = 0; data_in = 8'b10101010; #10;
        rst = 0; load = 1; data_in = 8'b11110000; #10;
        rst = 0; load = 0; data_in = 8'b00001111; #10;
        rst = 0; load = 1; data_in = 8'b11111111; #10;
        rst = 0; load = 0; data_in = 8'b00000000; #10;
        rst = 1; load = 0; data_in = 8'b10101010; #10;
        rst = 0; load = 1; data_in = 8'b01010101; #10;
        #10 $finish;
    end
endmodule