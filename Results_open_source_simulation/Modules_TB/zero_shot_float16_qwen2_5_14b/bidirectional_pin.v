module tb_bidir_pin;
    parameter WIDTH = 1;
    
    reg dir;
    reg [WIDTH-1:0] data_out;
    wire [WIDTH-1:0] data_in;
    wire [WIDTH-1:0] pin;
    
    bidir_pin uut (
        .pin(pin),
        .dir(dir),
        .data_out(data_out),
        .data_in(data_in)
    );
    
    initial begin
        $dumpfile("tb_bidir_pin.vcd");
        $dumpvars(0, tb_bidir_pin);
        
        // Initialize signals
        dir = 0;
        data_out = 0;
        
        #10 dir = 1; data_out = 1'b1; #10;
        #10 dir = 0; data_out = 1'b1; #10;
        #10 dir = 1; data_out = 1'b0; #10;
        #10 dir = 0; data_out = 1'b0; #10;
        #10 dir = 1; data_out = 1'b1; #10;
        #10 dir = 0; data_out = 1'b0; #10;
        #10 dir = 1; data_out = 1'b0; #10;
        #10 dir = 0; data_out = 1'b1; #10;
        
        #50 $finish;
    end
    
    always @(posedge pin) 
        $display("Time %0t: pin changed to %b", $time, pin);
    
    initial begin
        #100 $finish;
    end
endmodule