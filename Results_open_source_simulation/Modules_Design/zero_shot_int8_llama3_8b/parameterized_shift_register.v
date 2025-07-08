module param_shift_reg #(parameter WIDTH = 8)
    (input wire clk,
     input wire rst,
     input wire load,
     input wire [WIDTH-1:0] data_in,
     output reg [WIDTH-1:0] data_out);

reg [WIDTH-1:0] shift_reg;

always @(posedge clk) begin
    if (rst) begin
        shift_reg <= {WIDTH{1'b0}};
    end else if (load) begin
        shift_reg <= data_in;
    end else begin
        shift_reg <= {shift_reg[WIDTH-2:0], shift_reg[WIDTH-1]};
    end
end

assign data_out = shift_reg;

endmodule