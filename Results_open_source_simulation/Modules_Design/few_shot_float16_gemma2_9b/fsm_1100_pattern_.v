module fsm_1100 (
    input clk,
    input rst,
    input bit_in,
    output reg pattern_detected
);

  localparam S0 = 0;
  localparam S1 = 1;
  localparam S2 = 2;
  localparam S3 = 3;

  reg [2:0] state;

  always @(posedge clk) begin
    if (rst) begin
      state <= S0;
      pattern_detected <= 0;
    end else begin
      case (state)
        S0: if (bit_in == 1) state <= S1; else state <= S0;
        S1: if (bit_in == 1) state <= S2; else state <= S0;
        S2: if (bit_in == 0) state <= S3; else state <= S0;
        S3: if (bit_in == 0) state <= S0; else state <= S0;
      endcase
      if (state == S3) begin
        pattern_detected <= 1;
      end else begin
        pattern_detected <= 0;
      end
    end
  end

endmodule