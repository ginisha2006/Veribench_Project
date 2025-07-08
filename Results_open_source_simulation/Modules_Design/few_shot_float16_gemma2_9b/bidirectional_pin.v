module bidir_pin #(parameter WIDTH=1) (
    inout  pin[WIDTH-1:0],
    input  dir,
    input  data_out[WIDTH-1:0],
    output data_in[WIDTH-1:0]
);
    assign data_in = dir ? data_out : pin;
    assign pin = dir ? pin : data_in;
endmodule