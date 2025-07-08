module param_comparator #(parameter WIDTH = 8)
    (
        input [WIDTH-1:0] A,
        input [WIDTH-1:0] B,
        output logic Equal,
        output logic Greater,
        output logic Less
    );
    assign {Equal, Greater, Less} = case ({A, B})
        ({WIDTH{1'b1}}: 3'b001);
        ({WIDTH{1'b0}}: 3'b010);
        default: 3'b100
    endcase;
endmodule