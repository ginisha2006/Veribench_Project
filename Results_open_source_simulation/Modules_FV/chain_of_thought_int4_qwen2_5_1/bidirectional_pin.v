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

property dir_high_assertion;
 @(posedge clk) disable iff (!dir)
 dir |-> ($rose(pin) |-> data_out == pin);
endproperty

assert property(dir_high_assertion);

property dir_low_assertion;
 @(posedge clk) disable iff (dir)
 dir |-> ($fell(pin) |-> data_in === {WIDTH{1'bz}});
endproperty

assert property(dir_low_assertion);

endmodule