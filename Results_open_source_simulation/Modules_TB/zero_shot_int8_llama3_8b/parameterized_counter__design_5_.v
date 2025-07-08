module tb_param_counter();
    parameter MAX_COUNT = 256; // same as in the DUT
    reg clk;
    reg rst;
    wire [7:0] count;

    initial begin
        #10 clk = 1'b0;
        forever begin
            #20 clk = ~clk;
        end
    end

    initial begin
        rst = 1'b1;
        #100 rst = 1'b0;
    end

    param_counter dut (
       .clk(clk),
       .rst(rst),
       .count(count[7:0])
    );

    initial begin
        $monitor($time, "rst:", rst, "count:", $hbin(count));
    end
endmodule