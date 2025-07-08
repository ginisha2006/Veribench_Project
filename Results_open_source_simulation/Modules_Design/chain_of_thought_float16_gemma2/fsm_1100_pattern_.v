module fsm_1100 (
  input clk,
  input rst,
  input bit_in,
  output reg pattern_detected
);

  reg [3:0] state;

  always @(posedge clk) begin
    if (rst) begin
      state <= 4'b0000;
      pattern_detected <= 1'b0;
    end else begin
      case (state)
        4'b0000: if (bit_in == 1'b1) state <= 4'b0001;
        4'b0001: if (bit_in == 1'b1) state <= 4'b0011;
        4'b0011: if (bit_in == 1'b0) state <= 4'b0010;
        4'b0010: if (bit_in == 1'b0) state <= 4'b0110;
        4'b0110: if (bit_in == 1'b0) state <= 4'b1100;
        4'b1100: begin
          pattern_detected <= 1'b1;
          state <= 4'b0000;
        end
        default: state <= 4'b0000;
      endcase
    end
  end

endmodule