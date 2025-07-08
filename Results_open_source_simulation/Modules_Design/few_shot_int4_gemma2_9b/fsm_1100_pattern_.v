module fsm_1100 (
    input clk, rst, bit_in,
    output pattern_detected
);
  reg [3:0] state;
  assign pattern_detected = (state == 4'b1100);
  always @(posedge clk) begin
    if (rst) begin
      state <= 4'b0000;
    end else begin
      case (state)
        4'b0000: if (bit_in) state <= 4'b0001; else state <= 4'b0000;
        4'b0001: if (bit_in) state <= 4'b0010; else state <= 4'b0000;
        4'b0010: if (bit_in) state <= 4'b0011; else state <= 4'b0000;
        4'b0011: if (bit_in) state <= 4'b0100; else state <= 4'b0000;
        4'b0100: if (bit_in) state <= 4'b1000; else state <= 4'b0000;
        4'b1000: if (bit_in) state <= 4'b1100; else state <= 4'b0000;
        default: state <= 4'b0000;
      endcase
    end
  end
endmodule