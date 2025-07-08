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
    clear = 1; @(posedge clk); @(posedge clk);
    clear = 0; @(posedge clk);
    load = 1; d = 8'b1010_1010; @(posedge clk);
    load = 0; @(posedge clk);
    up_down = 1; @(posedge clk) for(int i=0; i<10; i++) @(posedge clk);
    up_down = 0; @(posedge clk) for(int i=0; i<10; i++) @(posedge clk);
    
    $finish;
end

initial begin
    $monitor($time," ns: clk=%b, clear=%b, load=%b, up_down=%b, qd=%h", clk, clear, load, up_down, qd);
end

endmodule