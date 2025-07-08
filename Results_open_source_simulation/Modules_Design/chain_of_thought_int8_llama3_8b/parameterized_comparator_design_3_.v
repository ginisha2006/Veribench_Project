module param_comparator #(parameter WIDTH = 8)
    (input [WIDTH-1:0] A,
     input [WIDTH-1:0] B,
     output logic Equal,
     output logic Greater,
     output logic Less);