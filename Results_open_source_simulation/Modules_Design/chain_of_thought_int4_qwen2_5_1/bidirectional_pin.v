module bidir_pin #(
    parameter int WIDTH = 1
)(
    inout wire [WIDTH-1:0] pin,
    input wire dir,
    input wire [WIDTH-1:0] data_out,
    output reg [WIDTH-1:0] data_in
);
    always @(posedge dir or posedge negedge pin)
        if (!dir)
            pin <= data_out;
        else
            data_in <= pin;
endmodule