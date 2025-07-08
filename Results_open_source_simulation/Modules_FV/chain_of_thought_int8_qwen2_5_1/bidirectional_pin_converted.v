module tb_bidir_pin;
    parameter WIDTH = 1;
    reg dir;
    reg [WIDTH-1:0] data_out;
    wire [WIDTH-1:0] data_in;
    inout [WIDTH-1:0] pin;
    
    bidir_pin #(.WIDTH(WIDTH)) uut (
        .pin(pin),
        .dir(dir),
        .data_out(data_out),
        .data_in(data_in)
    );
    
    reg clk;
    always #5 clk = ~clk;
    
    always @(*) begin assert (@(posedge clk) dir |-> !$isunknown(data_out)); end
    
    always @(*) begin assert (@(posedge clk) !dir |-> data_in == '{WIDTH{1'bx}}); end
    
    always @(*) begin assert (@(posedge clk) dir ##1 pin[0:$] == data_out); end
    
    always @(*) begin assert (@(negedge clk) !dir |-> pin[0:$] == '{WIDTH{1'bz}}); end
endmodule