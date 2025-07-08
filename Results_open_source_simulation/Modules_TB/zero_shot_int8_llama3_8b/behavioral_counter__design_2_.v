module behav_counter_tb();

reg clk;
reg clear;
reg load;
reg up_down;
wire [7:0] d;
wire [7:0] qd;

behav_counter dut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd(qd));

initial begin
    #100; // wait for 100 time units
    $monitor($time, "cnt = %h", qd);
    #500; // wait for 500 time units
    clear = 1; // reset counter
    #10;
    clear = 0;
    #10;
    load = 1; // load value 5
    d = 5;
    #10;
    load = 0;
    #10;
    up_down = 1; // increment counter
    #20;
    up_down = 0;
    #20;
    up_down = 1; // decrement counter
    #20;
    up_down = 0;
    #1000; // wait for 1000 time units
    $display("Simulation complete");
    $finish;
end

always #5 clk = ~clk; // generate clock signal

initial begin
    clk = 0;
    forever #10 clk = ~clk; // start clock at 0
end

endmodule