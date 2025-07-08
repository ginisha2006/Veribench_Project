module tb_param_shift_reg;
    parameter WIDTH = 8;
    reg clk;
    reg rst;
    reg load;
    reg [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] data_out;

    param_shift_reg #(.WIDTH(WIDTH)) uut (
        .clk(clk),
        .rst(rst),
        .load(load),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock generation
    end

    initial begin
        rst = 1;
        load = 0;
        data_in = 8'b0000_0000;
        #10;
        rst = 0;
        #10;
        
        for(int i=0; i<4; i++) begin
            data_in = {i{1'b1}};
            load = 1;
            #10;
            load = 0;
            #20;
        end
        
        data_in = 8'b1010_1010;
        load = 1;
        #10;
        load = 0;
        #30;
        
        data_in = 8'b1111_0000;
        load = 1;
        #10;
        load = 0;
        #40;
        
        rst = 1;
        #10;
        rst = 0;
        #10;
        
        $finish;
    end
    
    initial begin
        $monitor($time," ns: clk=%b, rst=%b, load=%b, data_in=%b, data_out=%b", clk, rst, load, data_in, data_out);
    end
endmodule