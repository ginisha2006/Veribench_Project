module tb_behav_counter;
reg [7:0] d;
reg clk;
reg clear;
reg load;
reg up_down;
wire [7:0] qd;

behav_counter uut (
    .d(d),
    .clk(clk),
    .clear(clear),
    .load(load),
    .up_down(up_down),
    .qd(qd)
);

initial begin
    // Initialize inputs
    d = 8'b0000_0000;
    clk = 0;
    clear = 0;
    load = 0;
    up_down = 0;

    // Clock generation
    forever #5 clk = ~clk;

    // Test sequence
    @(negedge clk);
    clear = 1; @(posedge clk); @(negedge clk);
    clear = 0; @(negedge clk);
    load = 1; d = 8'b0000_1111; @(negedge clk);
    load = 0; @(negedge clk);
    up_down = 1; @(negedge clk);
    for(int i=0; i<16; i++) @(negedge clk);
    up_down = 0; @(negedge clk);
    for(int i=0; i<16; i++) @(negedge clk);
    clear = 1; @(negedge clk);
end

initial begin
    $monitor("Time %t: clk=%b, clear=%b, load=%b, up_down=%b, qd=%h", $time, clk, clear, load, up_down, qd);
end

endmodule