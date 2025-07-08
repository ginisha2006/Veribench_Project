module bidir_pin #(parameter WIDTH=1) (
    inout [WIDTH-1:0] pin,
    input dir,
    input [WIDTH-1:0] data_out,
    output reg [WIDTH-1:0] data_in
);
    always @(posedge dir)
        if (dir)
            data_in <= data_out;
        else
            pin <= data_in;
endmodule