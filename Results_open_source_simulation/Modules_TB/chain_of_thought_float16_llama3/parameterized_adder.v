module tb_param_adder();

reg [7:0] a;
reg [7:0] b;
wire [7:0] sum;
wire carry;

param_adder #(.WIDTH(8)) DUT (.a(a),.b(b),.sum(sum),.carry(carry));

initial begin
    #10; // delay for setup
    a = 8'h12;
    b = 8'h34;
    #20;
    $display("Expected sum: %h, Expected carry: %b", 8'h46, 1'b1);
    #10;
    a = 8'ha5;
    b = 8'h6e;
    #20;
    $display("Expected sum: %h, Expected carry: %b", 8'hd, 1'b0);
    #10;
    a = 8'hff;
    b = 8'he0;
    #20;
    $display("Expected sum: %h, Expected carry: %b", 8'h00, 1'b1);
    #100;
    $finish;
end

always @(posedge a) begin
    $monitor($time, "a: %h, b: %h, sum: %h, carry: %b", a, b, sum, carry);
end

endmodule