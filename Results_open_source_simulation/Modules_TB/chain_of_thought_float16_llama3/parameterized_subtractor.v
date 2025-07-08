module param_subtractor_tb;

parameter WIDTH = 8;

reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
wire [WIDTH-1:0] diff;
wire borrow;

param_subtractor #(.WIDTH(WIDTH)) DUT (a, b, diff, borrow);

initial begin
    #10; // delay for setup
    a = 8'h12;
    b = 8'h5;
    #20;
    $display("Expected result: %h", 8'h7);
    $display("Actual result: %h", diff);
    $display("Borrow: %b", borrow);
    
    #10; // delay for setup
    a = 8'hA;
    b = 8'hF;
    #20;
    $display("Expected result: %h", 8'h3);
    $display("Actual result: %h", diff);
    $display("Borrow: %b", borrow);
    
    #10; // delay for setup
    a = 8'hz;
    b = 8'h0;
    #20;
    $display("Expected result: %h", 8'hz);
    $display("Actual result: %h", diff);
    $display("Borrow: %b", borrow);
    
    #100; // wait for all tests to complete
    
    $finish;
end

always #10 $monitor($time, "a=%h, b=%h, diff=%h, borrow=%b", a, b, diff, borrow);

endmodule