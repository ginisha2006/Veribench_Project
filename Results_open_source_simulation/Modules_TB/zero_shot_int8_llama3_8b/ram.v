module ram_testbench;

reg clk;

reg we;

integer i;

initial begin

#100 clk = 1;

repeat(10) begin

#50 clk = ~clk;

#50 clk = clk;

we = 1;

for (i = 0; i < 2**8; i++) begin

$display($time,"Writing address %d with value %h", i, 8'hAA);

mem[i] <= 8'hAA;

end

#100 we = 0;

#100 for (i = 0; i < 2**8; i++) begin

$display($time,"Reading address %d", i);

assert(data_out == mem[i]);

end

#1000 $finish;

end

always #5 clk = ~clk;

$monitor($time,"clk=%b, we=%b, addr=%d, data_in=%h, data_out=%h\n", clk, we, addr, data_in, data_out);

endmodule