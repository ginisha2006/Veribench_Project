module param_subtractor #(parameter WIDTH=8) (
    input [WIDTH-1:0] a, b,
    output [WIDTH-1:0] diff,
    output borrow
);
  dsp48  subtractor (
    .a(a),
    .b(b),
    .c(borrow),
    .p(diff)
  );
endmodule