module param_comparator(
  input [WIDTH-1:0] A,
  input [WIDTH-1:0] B,
  output reg Equal,
  output reg Greater,
  output reg Less
);

  always @(*) begin
    if (A == B) begin
      Equal = 1'b1;
      Greater = 1'b0;
      Less = 1'b0;
    end else if (A > B) begin
      Equal = 1'b0;
      Greater = 1'b1;
      Less = 1'b0;
    end else begin
      Equal = 1'b0;
      Greater = 1'b0;
      Less = 1'b1;
    end
  end

endmodule