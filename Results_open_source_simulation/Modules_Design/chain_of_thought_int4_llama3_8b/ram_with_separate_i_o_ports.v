module ram_separate_io #(parameter DATA_WIDTH = 8, parameter ADDR_WIDTH = 8)(input wire clk, input wire we, input wire [ADDR_WIDTH-1:0] addr, input wire [DATA_WIDTH-1:0] data_in, output reg [DATA_WIDTH-1:0] data_out);

always @(posedge clk) begin
if (~we) begin
data_out <= 'x;
end else if (addr!= 'b0) begin
data_out <= 'x;
end else begin
data_out <= data_in;
end
end

endmodule