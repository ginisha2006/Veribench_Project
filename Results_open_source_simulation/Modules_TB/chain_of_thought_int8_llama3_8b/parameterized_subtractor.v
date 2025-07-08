module tb_param_subtractor;

reg [7:0] a;
reg [7:0] b;
wire [7:0] diff;
wire borrow;

param_subtractor #(.WIDTH(8)) DUT (.a(a),.b(b),.diff(diff),.borrow(borrow));

initial begin
    #10; // wait for reset
    a = 8'h12;
    b = 8'h5;
    #20;
    $display("Expected result: %h", 8'h7);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);

    #100; // wait for next cycle
    a = 8'hA;
    b = 8'hF;
    #20;
    $display("Expected result: %h", 8'h3);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);

    #100; // wait for next cycle
    a = 8'hz;
    b = 8'h1;
    #20;
    $display("Expected result: %h", 8'hff);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);

    #100; // wait for next cycle
    a = 8'h0;
    b = 8'h0;
    #20;
    $display("Expected result: %h", 8'h0);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);

    #100; // wait for next cycle
    a = 8'hf;
    b = 8'he;
    #20;
    $display("Expected result: %h", 8'hd);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);

    #100; // wait for next cycle
    a = 8'h0;
    b = 8'h0;
    #20;
    $display("Expected result: %h", 8'h0);
    $monitor($time, "a=%b, b=%b, diff=%b, borrow=%b", a, b, diff, borrow);

    #10000; // run for 10ms
    $finish;
end

endmodule