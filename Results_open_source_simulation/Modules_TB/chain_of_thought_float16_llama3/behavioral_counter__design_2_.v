module behav_counter_tb();

reg clk;
reg clear;
reg load;
reg up_down;
wire [7:0] d;
wire [7:0] qd;

behav_counter dut (.d(d),.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd(qd));

initial begin
    #10; // initial delay
    clk = 0;
    forever begin
        #5 clk = ~clk; // toggle clock
    end
end

initial begin
    #20; // initial delay
    clear = 1; // reset counter
    @(posedge clk);
    clear = 0;
    
    #10;
    load = 1; // load value
    d = 8'h12;
    @(posedge clk);
    load = 0;
    
    #10;
    up_down = 1; // increment
    for (int i = 0; i < 5; i++) @(posedge clk);
    up_down = 0;
    
    #10;
    up_down = 1; // decrement
    for (int i = 0; i < 3; i++) @(posedge clk);
    up_down = 0;
    
    #100; // wait for some time
    
    $monitor($time, "cnt: %h", qd); // observe output
end

endmodule