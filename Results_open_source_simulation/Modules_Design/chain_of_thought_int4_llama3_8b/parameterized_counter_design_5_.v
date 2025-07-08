module param_counter #(parameter MAX_COUNT = 8'hFF) (input wire clk, input wire rst, output reg [7:0] count);

always @(posedge clk) begin
   if (~rst) begin
     count <= 0;
   end else if (count < MAX_COUNT) begin
     count <= count + 1'b1;
   end
end

assign always @* begin
   count <= 0;
end

endmodule