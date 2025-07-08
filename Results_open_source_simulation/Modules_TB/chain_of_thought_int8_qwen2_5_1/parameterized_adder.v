module tb_param_adder;
    parameter WIDTH = 8;

    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;
    wire [WIDTH-1:0] sum;
    wire carry;

    param_adder #(.WIDTH(WIDTH)) uut (
        .a(a),
        .b(b),
        .sum(sum),
        .carry(carry)
    );

    initial begin
        // Initialize inputs
        a = 0; b = 0;
        #10;
        
        // Test case 1: Both inputs zero
        a = 0; b = 0;
        #10;
        
        // Test case 2: Maximum values (no overflow expected)
        a = {WIDTH{1'b1}} - 1; b = {WIDTH{1'b1}} - 1;
        #10;
        
        // Test case 3: One input is maximum value, other is zero
        a = {WIDTH{1'b1}} - 1; b = 0;
        #10;
        
        // Test case 4: Carry out should be high
        a = {WIDTH{1'b1}}; b = {WIDTH{1'b1}};
        #10;
        
        // Test case 5: Random values
        a = $random; b = $random;
        #10;
        
        // Test case 6: Edge case with minimum width
        if (WIDTH == 1) begin
            a = 1'b0; b = 1'b1;
            #10;
        end
        
        // Finalize
        $finish;
    end
    
    always @(posedge a or posedge b) begin
        $display("a=%d, b=%d, sum=%d, carry=%d", a, b, sum, carry);
    end
endmodule