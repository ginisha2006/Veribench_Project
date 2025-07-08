module param_shift_reg #(parameter WIDTH = 8) (
    input wire clk,
    input wire rst,
    input wire load,
    input wire [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
);

reg [WIDTH-1:0] internal_data;

always @(posedge clk) begin
    if (rst) begin
        internal_data <= 'b0;
    end else if (load) begin
        internal_data <= data_in;
    end else begin
        internal_data <= {internal_data[WIDTH-2:0], internal_data[WIDTH-1]};
    end
end

assign data_out = internal_data;

endmodule