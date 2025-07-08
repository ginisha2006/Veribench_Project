module bidir_pin (
    inout wire [WIDTH-1:0] pin,
    input wire dir,
    input wire [WIDTH-1:0] data_out,
    output reg [WIDTH-1:0] data_in
);
always @(posedge dir) begin
    if (dir) begin
        data_in <= data_out;
    end else begin
        data_in <= 'z';
    end
end
endmodule