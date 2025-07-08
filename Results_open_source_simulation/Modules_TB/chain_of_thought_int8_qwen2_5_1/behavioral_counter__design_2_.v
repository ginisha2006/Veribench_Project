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
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    d = 8'b0000_0000;
    clear = 0; load = 0; up_down = 0;
    #10 clear = 1; load = 0; up_down = 0;
    #10 load = 1; d = 8'b0000_1111;
    #10 load = 0; up_down = 1;
    repeat(16) begin
        #10 up_down = !up_down;
    end
    #10 clear = 1;
    #10 clear = 0;
    #10 $finish;
end

initial begin
    $monitor($time,"ns %b",qd);
end

endmodule