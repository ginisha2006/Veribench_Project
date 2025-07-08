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
    $monitor($time, "Clear", clear);
    clear = 1'b1;
    #10;
    clear = 1'b0;
    #10;
    $monitor($time, "Load with value 5", d, 8'd5);
    d = 8'd5;
    load = 1'b1;
    #10;
    load = 1'b0;
    #10;
    $monitor($time, "Up");
    up_down = 1'b1;
    #20;
    $monitor($time, "Down");
    up_down = 1'b0;
    #20;
    $monitor($time, "Up again");
    up_down = 1'b1;
    #50;
    $monitor($time, "Down again");
    up_down = 1'b0;
    #100;
    $finish;
end

always #5 clk = ~clk;

initial begin
    clk = 1'b0;
    repeat (100) @(posedge clk);
end

endmodule