module tb_param_comparator;

  reg [7:0] A;
  reg [7:0] B;
  wire Equal;
  wire Greater;
  wire Less;

  param_comparator #( .WIDTH(8) ) dut (
    .A(A),
    .B(B),
    .Equal(Equal),
    .Greater(Greater),
    .Less(Less)
  );

  always @(*) begin assert (A == B  implies (Equal && !Greater && !Less)); end
  always @(*) begin assert (A > B implies (Greater && !Equal && !Less)); end
  always @(*) begin assert (A < B implies (!Greater && !Equal && Less)); end


endmodule