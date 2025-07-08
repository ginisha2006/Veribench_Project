module tb_param_shift_reg;

parameter WIDTH = 8;
reg clk;
reg rst;
reg load;
wire [WIDTH-1:0] data_in;
wire [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) dut (
   .clk(clk),
   .rst(rst),
   .load(load),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    #10; // delay for setup
    rst = 1; // reset
    load = 0;
    data_in = 0;
    repeat(5) @(posedge clk); // wait for clock cycles
    rst = 0; // release reset
    load = 1; // load new value
    data_in = 8'hAA; // set new value
    repeat(5) @(posedge clk); // wait for clock cycles
    load = 0; // stop loading
    repeat(10) @(posedge clk); // wait for clock cycles
    $monitor($time, "clk=%b rst=%b load=%b data_in=%h data_out=%h", clk, rst, load, data_in, data_out);
end

always #5 clk = ~clk; // generate clock

endmodule