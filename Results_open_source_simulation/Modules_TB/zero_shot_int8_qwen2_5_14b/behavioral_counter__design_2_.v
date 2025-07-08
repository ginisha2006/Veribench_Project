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
        clk = 0;
        d = 8'b0000_0000;
        clear = 0;
        load = 0;
        up_down = 0;
        
        #10 clear = 1;
        #10 load = 1;
        d = 8'b1111_1111;
        #10 load = 0;
        #10 up_down = 1;
        #40 up_down = 0;
        #30 up_down = 1;
        #50 clear = 0;
        #10 clear = 1;
        #10 load = 1;
        d = 8'b0000_0001;
        #10 load = 0;
        #10 up_down = 1;
        #60 up_down = 0;
        #70 $stop;
    end
    
    always #5 clk = ~clk;
    
    initial begin
        $monitor($time, " ns: clk=%b, clear=%b, load=%b, up_down=%b, d=%h, qd=%h", clk, clear, load, up_down, d, qd);
    end
endmodule