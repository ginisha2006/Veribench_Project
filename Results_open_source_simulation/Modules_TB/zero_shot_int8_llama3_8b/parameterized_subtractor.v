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
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);
    
    #100; // delay for setup
    a = 8'hA;
    b = 8'hF;
    #20;
    $display("Expected result: %h", 8'h3);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);
    
    #100; // delay for setup
    a = 8'HF;
    b = 8'H0;
    #20;
    $display("Expected result: %h", 8'hFF);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);
    
    #100; // delay for setup
    a = 8'HF;
    b = 8'HF;
    #20;
    $display("Expected result: %h", 8'HE);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);
    
    #100; // delay for setup
    a = 8'0;
    b = 8'0;
    #20;
    $display("Expected result: %h", 8'0);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);
    
    #100; // delay for setup
    a = 8'0;
    b = 8'1;
    #20;
    $display("Expected result: %h", 8'f);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);
    
    #100; // delay for setup
    a = 8'z;
    b = 8'z;
    #20;
    $display("Expected result: %h", 8'z);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);
    
    #10000; // run for 10ms
    
    $finish;
end

endmodule