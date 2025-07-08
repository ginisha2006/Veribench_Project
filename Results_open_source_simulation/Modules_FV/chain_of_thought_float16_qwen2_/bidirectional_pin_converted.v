module tb_bidir_pin;
    logic [0:0] pin;
    logic dir;
    logic [0:0] data_out;
    logic [0:0] data_in;
    
    bidir_pin #(.WIDTH(1)) uut (
        .pin(pin),
        .dir(dir),
        .data_out(data_out),
        .data_in(data_in)
    );
    
    always begin
        #(5ns) clk = 1'b1;
        #(5ns) clk = 1'b0;
    end
    
    always @(*) begin assert (@(posedge clk) dir == 1'b1 |=> !$isunknown(pin)); end
    
    always @(*) begin assert (@(posedge clk) dir == 1'b0 |=> pin === 1'bz); end
    
    always @(*) begin assert (@(posedge clk) dir ##1 dir |-> data_out !== pin); end
    
    always @(*) begin assert (@(negedge clk) dir == 1'b0 && !$isunknown(pin) |-> data_in == pin); end
    
    always @(*) begin assert (@(negedge clk) dir == 1'b1 && !$isunknown(data_out) |-> pin == data_out); end
    
    always @(*) begin assert (@(posedge clk) !($isunknown(dir) || $isunknown(data_out)) |-> !(dir && $isunknown(pin))); end
endmodule