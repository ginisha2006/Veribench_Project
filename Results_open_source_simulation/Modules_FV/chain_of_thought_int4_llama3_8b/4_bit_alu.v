module tb_alu_4bit;
    parameter PERIOD = 20;

    logic [3:0] a, b;
    logic [2:0] ALU_Sel;
    logic [3:0] ALU_Result_exp;
    logic Zero_exp, Carry_exp, Overflow_exp;

    alu_4bit dut (
       .a(a),
       .b(b),
       .ALU_Sel(ALU_Sel),
       .ALU_Result(ALU_Result_exp),
       .Zero(Zero_exp),
       .Carry(Carry_exp),
       .Overflow(Overflow_exp)
    );

    property add_property;
        @(posedge clk)
        (ALU_Sel == 3'b000) |=> ($rose(Overflow) |=> (ALU_Result_exp == a + b));
    endproperty

    property sub_property;
        @(posedge clk)
        (ALU_Sel == 3'b001) |=> ($rose(Overflow) |=> (ALU_Result_exp == a - b));
    endproperty

    property and_property;
        @(posedge clk)
        (ALU_Sel == 3'b010) |=> (ALU_Result_exp == a & b);
    endproperty

    property or_property;
        @(posedge clk)
        (ALU_Sel == 3'b011) |=> (ALU_Result_exp == a | b);
    endproperty

    property xor_property;
        @(posedge clk)
        (ALU_Sel == 3'b100) |=> (ALU_Result_exp == a ^ b);
    endproperty

    property not_property;
        @(posedge clk)
        (ALU_Sel == 3'b101) |=> (ALU_Result_exp == ~a);
    endproperty

    property shl_property;
        @(posedge clk)
        (ALU_Sel == 3'b110) |=> (ALU_Result_exp == a << 1);
    endproperty

    property shr_property;
        @(posedge clk)
        (ALU_Sel == 3'b111) |=> (ALU_Result_exp == a >> 1);
    endproperty

    property zero_property;
        @(posedge clk)
        (ALU_Sel!= 3'b111) |=> (!Zero_exp |=> (ALU_Result_exp!= 4'b0000));
    endproperty

    property overflow_property;
        @(posedge clk)
        (ALU_Sel == 3'b000) |=> (Overflow_exp |=> (ALU_Result_exp[3]!= a[3]));
    endproperty

    always #PERIOD clk = ~clk;

    assert property(add_property);
    assert property(sub_property);
    assert property(and_property);
    assert property(or_property);
    assert property(xor_property);
    assert property(not_property);
    assert property(shl_property);
    assert property(shr_property);
    assert property(zero_property);
    assert property(overflow_property);

endmodule