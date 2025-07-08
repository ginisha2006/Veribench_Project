module tb_bidir_pin (
    inout [WIDTH-1:0] pin,
    input dir,
    input [WIDTH-1:0] data_out,
    output [WIDTH-1:0] data_in
);
parameter WIDTH = 1;
logic clk;
bidir_pin #(.WIDTH(WIDTH)) uut (
    .pin(pin),
    .dir(dir),
    .data_out(data_out),
    .data_in(data_in)
);

always begin
    #5 clk = ~clk;
end

assert (@(posedge clk) disable iff (!dir)
 dir |-> ($rose(pin) |-> data_out == pin));

assert (@(posedge clk) disable iff (dir)
 dir |-> ($fell(pin) |-> data_in === {WIDTH{1'bz}}));

endmodule