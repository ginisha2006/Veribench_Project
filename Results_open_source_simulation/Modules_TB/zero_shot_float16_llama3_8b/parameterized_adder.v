module tb_param_adder;

parameter WIDTH = 8;

reg [WIDTH-1:0] a;
reg [WIDTH-1:0] b;
wire [WIDTH-1:0] sum;
wire carry;

param_adder #(.WIDTH(WIDTH)) DUT (a, b, sum, carry);

initial begin
    #100; // delay for setup
    a = 5'b1010_0001;
    b = 5'b0101_0110;
    #10;
    $display("Expected sum: %b, Expected carry: %b", 12'h2A, 1'bx);
    #10;
    a = 8'hFF;
    b = 8'h01;
    #10;
    $display("Expected sum: %b, Expected carry: %b", 9'h100, 1'bx);
    #10;
    a = 8'h00;
    b = 8'h00;
    #10;
    $display("Expected sum: %b, Expected carry: %b", 8'h0, 1'bx);
    #20;
    $finish;
end

always @(posedge a) begin
    $monitor($time, "a: %b, b: %b, sum: %b, carry: %b", a, b, sum, carry);
end

endmodule