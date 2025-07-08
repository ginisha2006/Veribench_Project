module tb_param_subtractor;

parameter WIDTH = 8;
reg [WIDTH-1:0] a, b;
wire [WIDTH-1:0] diff;
wire borrow;

param_subtractor #(.WIDTH(WIDTH)) DUT (a, b, diff, borrow);

initial begin
    #10; // delay for setup
    a = 8'h12; b = 8'h5; // normal subtraction
    #20;
    $monitor($time, "a=$b, b=$c, diff=$d, borrow=$e", a, b, diff, borrow);
    
    a = 8'hFF; b = 8'hFE; // max value subtraction with borrow
    #20;
    $monitor($time, "a=$b, b=$c, diff=$d, borrow=$e", a, b, diff, borrow);
    
    a = 8'bx; b = 8'h5; // x in a
    #20;
    $monitor($time, "a=$b, b=$c, diff=$d, borrow=$e", a, b, diff, borrow);
    
    a = 8'h12; b = 8'hFF; // max value subtraction without borrow
    #20;
    $monitor($time, "a=$b, b=$c, diff=$d, borrow=$e", a, b, diff, borrow);
    
    #100; // hold for some time
    
    $finish;
end

endmodule