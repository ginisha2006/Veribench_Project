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
    end else begin
      case (state)
        S0: if (bit_in == 1) begin
          state <= S1;
        end else begin
          state <= S0;
        end
        S1: if (bit_in == 1) begin
          state <= S2;
        end else begin
          state <= S0;
        end
        S2: if (bit_in == 0) begin
          state <= S3;
        end else begin
          state <= S0;
        end
        S3: if (bit_in == 0) begin
          pattern_detected <= 1;
          state <= S0;
        end else begin
          state <= S0;
        end
      endcase
    end
  end

endmodule