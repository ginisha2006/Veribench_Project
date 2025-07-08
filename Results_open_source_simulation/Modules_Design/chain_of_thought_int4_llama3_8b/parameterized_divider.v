module param_divider #(parameter WIDTH = 8)(input [WIDTH-1:0] dividend, input [WIDTH-1:0] divisor, output [WIDTH-1:0] quotient, output [WIDTH-1:0] remainder);

always @(posedge clock) begin

   if (~divisor == 0) begin

      $display("Error: Division by zero!");

      $stop;

   end else begin

      quotient <= dividend;

      remainder <= dividend & ~divisor;

   end

end

always @(posedge clock) begin

   if (~divisor == 0) begin

      $display("Error: Division by zero!");

      $stop;

   end else begin

      dividend <= dividend - {1'b1, remainder};

   end

end

endmodule