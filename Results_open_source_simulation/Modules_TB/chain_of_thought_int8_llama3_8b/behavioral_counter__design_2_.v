module behav_counter_tb();

reg [7:0] d;
reg clk;
reg clear;
reg load;
reg up_down;
wire [7:0] qd;

behav_counter dut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd(qd));

initial begin
    #10; // initial delay
    d = 5; // set initial value for 'd'
    load = 1; // load initial value
    up_down = 0; // default direction is down
    clear = 0; // default clear state
    clk = 0; // reset clock
    #20; // wait for 2 clock cycles
    load = 0; // stop loading
    #10; // wait for 1 clock cycle
    up_down = 1; // change direction to up
    #50; // wait for 5 clock cycles
    clear = 1; // clear counter
    #10; // wait for 1 clock cycle
    clear = 0; // restore clear state
    #100; // wait for 10 clock cycles
    $monitor($time, "cnt: %b", qd);
end

always #10 clk = ~clk; // toggle clock

endmodule