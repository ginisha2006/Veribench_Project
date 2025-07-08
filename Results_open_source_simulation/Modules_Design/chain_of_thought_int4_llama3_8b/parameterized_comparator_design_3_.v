module param_comparator #(parameter WIDTH = 8)(input [WIDTH-1:0] A, input [WIDTH-1:0] B, output logic Equal, output logic Greater, output logic Less);

always @* begin

if (~|A[W-1:0] & |B[W-1:0]) begin

Less <= 1;

Equal <= 0;

Greater <= 0;

end else if (&A[W-1:0] & ~|B[W-1:0]) begin

Less <= 0;

Equal <= 0;

Greater <= 1;

end else if (&A[W-1:0] & |B[W-1:0]) begin

Less <= 0;

Equal <= 1;

Greater <= 0;

end else begin

Less <= 0;

Equal <= 1;

Greater <= 1;

end

end

endmodule