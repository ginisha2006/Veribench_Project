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
    $monitor ($time, "clk = %b", clk);
    $monitor ($time, "clear = %b", clear);
    $monitor ($time, "load = %b", load);
    $monitor ($time, "up_down = %b", up_down);
    $monitor ($time, "d = %h", d);
    $monitor ($time, "qd = %h", qd);

    // Test case 1: Clear counter
    clear = 1'b1;
    #20;
    assert(qd == 8'h0) else $error("Clear failed");
    
    // Test case 2: Load counter with value
    d = 8'h12;
    load = 1'b1;
    clear = 1'b0;
    up_down = 1'bx;
    #40;
    assert(qd == 8'h12) else $error("Load failed");

    // Test case 3: Increment counter
    up_down = 1'b1;
    #60;
    assert(qd == 8'h13) else $error("Increment failed");

    // Test case 4: Decrement counter
    up_down = 1'b0;
    #80;
    assert(qd == 8'h11) else $error("Decrement failed");

    // Test case 5: Multiple increments and decrements
    repeat(5) begin
        up_down = 1'b1;
        #20;
        assert(qd == $countones(qd)) else $error("Multiple increment failed");
        up_down = 1'b0;
        #20;
        assert(qd == $countzeros(qd)) else $error("Multiple decrement failed");
    end

    $finish;
end

endmodule