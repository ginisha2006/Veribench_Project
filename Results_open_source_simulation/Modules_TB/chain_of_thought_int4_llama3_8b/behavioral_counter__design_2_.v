module behav_counter_tb();

reg clk;
reg clear;
reg load;
reg up_down;
wire [7:0] d;
wire [7:0] qd;

behav_counter dut (.clk(clk),.clear(clear),.load(load),.up_down(up_down),.qd(qd));

initial begin
    #10; // delay for setup
    clk = 0;
    forever begin
        #5 clk = ~clk; // toggle clock
    end
end

initial begin
    #20; // delay for setup
    clear = 1; // reset counter
    load = 0;
    up_down = 0;
    d = 8'h12; // initial value
    @(posedge clk); // wait for first clock cycle
    $monitor($time, "cnt: %h", qd);
    
    #50; // wait for some cycles
    
    clear = 0; // stop clearing
    load = 1; // load new value
    d = 8'h34; // new value
    @(posedge clk); // wait for clock cycle
    $monitor($time, "cnt: %h", qd);
    
    #50; // wait for some cycles
    
    up_down = 1; // increment counter
    @(posedge clk); // wait for clock cycle
    $monitor($time, "cnt: %h", qd);
    
    #50; // wait for some cycles
    
    up_down = 0; // decrement counter
    @(posedge clk); // wait for clock cycle
    $monitor($time, "cnt: %h", qd);
    
    #50; // wait for some cycles
    
    load = 0; // stop loading
    up_down = 0; // stop updating
    clear = 1; // reset counter again
    @(posedge clk); // wait for clock cycle
    $monitor($time, "cnt: %h", qd);
    
    #100; // wait for some more cycles
    $finish; // finish simulation
end

endmodule