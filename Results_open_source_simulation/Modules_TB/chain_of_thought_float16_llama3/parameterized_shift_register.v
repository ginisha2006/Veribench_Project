module shift_reg_tb;

parameter WIDTH = 8;

reg clk;
reg rst;
reg load;
wire [WIDTH-1:0] data_in;
wire [WIDTH-1:0] data_out;

param_shift_reg #(.WIDTH(WIDTH)) DUT (
   .clk(clk),
   .rst(rst),
   .load(load),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    #5 clk = 0; rst = 1; load = 0; data_in = 0;
    #10 rst = 0;
    #20 load = 1; data_in = 4'hA;
    #10 load = 0;
    #100 $display("Expected value at data_out: %h", 4'hA);
    #10 clk = 1; #10 clk = 0;
    repeat(3) begin
        #10 clk = 1; #10 clk = 0;
    end
    #10 load = 1; data_in = 4'hB;
    #10 load = 0;
    #100 $display("Expected value at data_out: %h", 4'hB);
    #10 clk = 1; #10 clk = 0;
    repeat(3) begin
        #10 clk = 1; #10 clk = 0;
    end
    $monitor($time, " clk:%b rst:%b load:%b data_in:%h data_out:%h");
    #1000 $finish;
end

always #5 clk = ~clk;

endmodule