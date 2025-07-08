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

    initial begin
        rst = 1;
        load = 0;
        data_in = 8'b0;
        #10 rst = 0;
        #10 load = 1;
        data_in = 8'b10101010;
        #10 load = 0;
        #10 data_in = 8'b11110000;
        #10 load = 1;
        data_in = 8'b00001111;
        #10 load = 0;
        #10 data_in = 8'bz; // Test with Z value
        #10 load = 1;
        data_in = 8'hFF;
        #10 load = 0;
        #10 $finish;
    end

    param_shift_reg uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_param_shift_reg);
    end

    initial begin
        #10 $monitor($time," ns | rst=%b, load=%b, data_in=%b, data_out=%b", rst, load, data_in, data_out);
    end
endmodule