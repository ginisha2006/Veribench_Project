module param_shift_reg(
  input clk,
  input rst,
  input load,
  input [WIDTH-1:0] data_in,
  output [WIDTH-1:0] data_out
);

  parameter WIDTH = 8;

  reg [WIDTH-1:0] shift_reg;

  always @(posedge clk) begin
    if (rst) begin
      shift_reg <= 0;
    end else if (load) begin
      shift_reg <= data_in;
    end else begin
      shift_reg <= {shift_reg[WIDTH-2:0], 1'b0};
    end
  end

  assign data_out = shift_reg;

endmodule