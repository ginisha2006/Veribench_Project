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
        
        #10 clear = 1;
        #10 load = 1;
        d = 8'b0000_1111;
        #10 load = 0;
        #10 up_down = 1;
        #50 up_down = 0;
        #50 clear = 1;
        #10 clear = 0;
        #10 $finish;
    end
    
    always #5 clk = ~clk;
    
    initial begin
        $monitor($time, " ns: d=%b, clk=%b, clear=%b, load=%b, up_down=%b, qd=%b", 
                 d, clk, clear, load, up_down, qd);
    end
endmodule