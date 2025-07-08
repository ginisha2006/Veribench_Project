module ternary_adder_tree #(parameter WIDTH = 16);
input [WIDTH-1:0] A, B, C, D, E;
input CLK;
output reg [WIDTH-1:0] OUT;

reg [WIDTH-1:0] temp_A, temp_B, temp_C, temp_D, temp_E;
wire [WIDTH-1:0] carry_in, carry_out;

always @(posedge CLK)
begin
    temp_A <= A;
    temp_B <= B;
    temp_C <= C;
    temp_D <= D;
    temp_E <= E;
end

assign carry_in = temp_A[0] ^ temp_B[0] ^ temp_C[0];
assign OUT[0] = temp_A[0] ^ temp_B[0] ^ temp_C[0];

for (genvar i = 1; i < WIDTH; i++)
begin: loop
    assign carry_out[i] = temp_A[i] ^ temp_B[i] ^ temp_C[i] ^ temp_D[i-1];
    assign temp_A[i] = temp_A[i+1] ^ temp_B[i+1] ^ temp_C[i+1] ^ temp_D[i];
    assign temp_B[i] = temp_B[i+1] ^ temp_C[i+1] ^ temp_D[i];
    assign temp_C[i] = temp_C[i+1] ^ temp_D[i];
    assign temp_D[i] = temp_D[i+1];
    assign temp_E[i] = temp_E[i+1];
end

assign OUT[i] = temp_A[i] ^ temp_B[i] ^ temp_C[i] ^ temp_D[i-1] ^ temp_E[i];

endmodule