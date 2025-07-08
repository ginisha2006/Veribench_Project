module param_subtractor_tb;

parameter WIDTH = 8;

reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
wire [WIDTH-1:0] diff;
wire borrow;

param_subtractor #(.WIDTH(WIDTH)) DUT (a, b, diff, borrow);

initial begin
    #100; // delay for setup
    a = 8'h12;
    b = 8'h5;
    #10;
    $display("Expected result: %h", 8'h7);
    $display("Actual result: %h", diff);
    $display("Borrow: %b", borrow);
    
    #100; // delay for setup
    a = 8'hA;
    b = 8'hF;
    #10;
    $display("Expected result: %h", 8'h3);
    $display("Actual result: %h", diff);
    $display("Borrow: %b", borrow);
    
    #100; // delay for setup
    a = 8'hz;
    b = 8'h0;
    #10;
    $display("Expected result: %h", 8'hz);
    $display("Actual result: %h", diff);
    $display("Borrow: %b", borrow);
    
    #100; // delay for setup
    a = 8'h0;
    b = 8'h1;
    #10;
    $display("Expected result: %h", 8'hf);
    $display("Actual result: %h", diff);
    $display("Borrow: %b", borrow);
    
    #100; // delay for setup
    a = 8'hFF;
    b = 8'hFE;
    #10;
    $display("Expected result: %h", 8'1);
    $display("Actual result: %h", diff);
    $display("Borrow: %b", borrow);
    
    #100; // delay for setup
    a = 8'h0;
    b = 8'h0;
    #10;
    $display("Expected result: %h", 8'h0);
    $display("Actual result: %h", diff);
    $display("Borrow: %b", borrow);
    
    #100; // delay for setup
    $finish;
end

always @(*) begin
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);
end

endmodule