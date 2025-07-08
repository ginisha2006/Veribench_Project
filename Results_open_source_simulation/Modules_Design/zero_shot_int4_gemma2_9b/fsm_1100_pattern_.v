module fsm_1100 (clk, rst, bit_in, pattern_detected);
  input clk;
  input rst;
  input bit_in;
  output pattern_detected;
  reg [3:0] state;
  assign pattern_detected = (state == 4'b1100);
  always @(posedge clk) begin
    if (rst) begin
      state <= 4'b0000;
    end else begin
      case (state)
        4'b0000: if (bit_in) state <= 4'b0001;
        4'b0001: if (bit_in) state <= 4'b0011;
        4'b0011: if (bit_in) state <= 4'b0111;
        4'b0111: if (bit_in) state <= 4'b1111;
        4'b1111: state <= 4'b0000;
        default: state <= 4'b0000;
      endcase
    end
  end
endmodule