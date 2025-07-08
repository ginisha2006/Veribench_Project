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
        forever #5 clk = ~clk; // Clock toggles every 10 time units
    end

    initial begin
        rst = 1;
        load = 0;
        data_in = 8'b0;
        #10;
        rst = 0;
        #10;
        
        // Test case 1: Load with all zeros
        data_in = 8'b0;
        load = 1;
        #10;
        load = 0;
        #10;
        
        // Test case 2: Load with random values
        data_in = 8'b10101010;
        load = 1;
        #10;
        load = 0;
        #10;
        
        // Test case 3: Reset condition
        rst = 1;
        #10;
        rst = 0;
        #10;
        
        // Test case 4: Load again after reset
        data_in = 8'b11110000;
        load = 1;
        #10;
        load = 0;
        #10;
        
        // End of tests
        $finish;
    end
    
    initial begin
        $monitor($time, " ns: clk=%b, rst=%b, load=%b, data_in=%b, data_out=%b", clk, rst, load, data_in, data_out);
    end
endmodule