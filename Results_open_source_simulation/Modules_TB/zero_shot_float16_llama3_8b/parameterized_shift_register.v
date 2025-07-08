module shift_reg_tb;

parameter WIDTH = 8;

reg clk;
reg rst;
reg load;
wire [WIDTH-1:0] data_in;
wire [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) DUT (
   .clk(clk),
   .rst(rst),
   .load(load),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    #100; // wait for 100 time units
    rst = 1; // reset
    #10; // wait for 10 time units
    rst = 0; // release reset
    #20; // wait for 20 time units
    load = 1; // load new value
    data_in = 16'hAABB; // set data_in to 0xAABB
    #10; // wait for 10 time units
    load = 0; // stop loading
    #50; // wait for 50 time units
    $monitor($time, "rst=%b, load=%b, data_in=%h, data_out=%h", rst, load, data_in, data_out);
    #100; // run for 100 time units
    $display("Simulation complete");
    $stop;
end

always #5 clk = ~clk; // clock generation

initial begin
    clk = 0; // initialize clock
    forever #10 clk = ~clk; // generate clock
end

endmodule