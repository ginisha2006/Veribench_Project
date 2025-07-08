module param_shift_reg #(parameter WIDTH = 8)
    (input wire clk,
     input wire rst,
     input wire load,
     input wire [WIDTH-1:0] data_in,
     output reg [WIDTH-1:0] data_out);

always @(posedge clk) begin
    if (rst) begin
        data_out <= {WIDTH{1'b0}};
    end else if (load) begin
        data_out <= data_in;
    end else begin
        data_out <= {data_out[WIDTH-2:0], data_in[WIDTH-1]};
    end
end

endmodule