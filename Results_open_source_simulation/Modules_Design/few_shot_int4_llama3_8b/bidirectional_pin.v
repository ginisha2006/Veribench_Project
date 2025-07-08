module bidir_pin #(parameter WIDTH=1) (
    inout [WIDTH-1:0] pin,
    input dir,
    input [WIDTH-1:0] data_out,
    output [WIDTH-1:0] data_in
);
    always @(posedge dir)
        begin
            if (dir)
                data_in <= data_out;
            else
                pin <= data_in;
        end
endmodule