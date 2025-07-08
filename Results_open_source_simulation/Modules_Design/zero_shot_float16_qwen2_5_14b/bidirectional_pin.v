module bidir_pin #(
    parameter WIDTH = 1
)(
    inout wire [WIDTH-1:0] pin,
    input wire dir,
    input wire [WIDTH-1:0] data_out,
    output reg [WIDTH-1:0] data_in
);
    always @* begin
        if(dir)
            pin <= data_out;
        else
            data_in = pin;
    end
endmodule