module shift_reg_tb;

parameter WIDTH = 8;

reg clk;
reg rst;
reg load;
wire [WIDTH-1:0] data_in;
wire [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) uut (
   .clk(clk),
   .rst(rst),
   .load(load),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    #10 clk = 0; rst = 1; load = 0; data_in = 0;
    #20 rst = 0; load = 0; data_in = 5;
    #10 load = 1; data_in = 3;
    #10 load = 0;
    #100 $display("Final value of data_out: %h", data_out);
    $monitor($time, "clk=%b, rst=%b, load=%b, data_in=%h, data_out=%h", clk, rst, load, data_in, data_out);
end

always #5 clk = ~clk;

endmodule