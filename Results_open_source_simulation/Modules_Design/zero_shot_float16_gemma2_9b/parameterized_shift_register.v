module param_shift_reg(
  input clk,
  input rst,
  input load,
  input [WIDTH-1:0] data_in,
  output reg [WIDTH-1:0] data_out
);

  parameter WIDTH = 8;

  always @(posedge clk) begin
    if (rst) begin
      data_out <= 0;
    end else if (load) begin
      data_out <= data_in;
    end else begin
      data_out <= {data_out[WIDTH-2:0], data_in[WIDTH-1]};
    end
  end

endmodule