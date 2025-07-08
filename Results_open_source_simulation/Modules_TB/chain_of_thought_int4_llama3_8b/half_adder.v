module tb_half_adder;

reg clk;
reg rst_n;
wire [1:0] a;
wire [1:0] b;
wire [1:0] sum;
wire carry;

initial begin
    #10; // delay for setup
    rst_n = 1'b0; // reset
    #5; // hold reset low for 5 cycles
    rst_n = 1'b1; // release reset
    #20; // wait for 20 cycles
    $monitor($time, "a=%b, b=%b, sum=%b, carry=%b", a, b, sum, carry);
    #50; // run for 50 cycles
    $finish;
end

initial begin
    forever begin
        #10; // clock period
        clk = ~clk; // toggle clock
    end
end

initial begin
    a = 2'b00; // initial values
    b = 2'b00;
    repeat (10) begin
        #10; // wait for clock cycle
        a = a + 1; // increment a
        if (a == 3'b111) a = 2'b00; // wrap around
        b = b + 1; // increment b
        if (b == 3'b111) b = 2'b00; // wrap around
    end
end

half_adder uut (
   .a(a),
   .b(b),
   .sum(sum),
   .carry(carry)
);

always @(posedge clk) begin
    #1; // delay for setup
    $display("Testing half adder with a=%b, b=%b", a, b);
    #10; // run for 10 cycles
    $display("Sum: %b, Carry: %b", sum, carry);
    #10; // run for 10 cycles
    $display("Done testing half adder");
    #10; // run for 10 cycles
end

endmodule