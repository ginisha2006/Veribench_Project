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
        4'b0000: begin
          if (bit_in == 1'b1) begin
            state <= 4'b0001;
          end
        end
        4'b0001: begin
          if (bit_in == 1'b1) begin
            state <= 4'b0011;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0011: begin
          if (bit_in == 1'b0) begin
            state <= 4'b0111;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b0111: begin
          if (bit_in == 1'b0) begin
            state <= 4'b1111;
          end else begin
            state <= 4'b0000;
          end
        end
        4'b1111: begin
          pattern_detected <= 1'b1;
          state <= 4'b0000;
        end
        default: begin
          state <= 4'b0000;
        end
      endcase
    end
  end

endmodule