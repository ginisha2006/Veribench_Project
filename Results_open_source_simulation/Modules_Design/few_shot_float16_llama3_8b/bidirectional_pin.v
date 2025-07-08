module bidir_pin #(parameter WIDTH=1) (
    inout [WIDTH-1:0] pin,
    input dir,
    input [WIDTH-1:0] data_out,
    output reg [WIDTH-1:0] data_in
);
    always @ (posedge dir)
        begin
            if (dir)
                pin <= #1 data_out;
            else
                data_in <= #1 pin;
        end
endmodule