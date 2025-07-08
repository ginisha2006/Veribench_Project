module bidir_pin #(parameter WIDTH = 1);
input [WIDTH-1:0] dir;
inout [WIDTH-1:0] pin;
input [WIDTH-1:0] data_out;
output reg [WIDTH-1:0] data_in;

always @(posedge dir)
    if (~dir) data_in <= data_out;
else
    data_in <= {WIDTH{1'b0}};

assign pin = data_in;
endmodule