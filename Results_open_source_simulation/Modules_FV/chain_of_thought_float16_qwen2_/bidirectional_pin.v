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
    
    property p_dir_high;
        @(posedge clk) dir == 1'b1 |=> !$isunknown(pin);
    endproperty
    assert property(p_dir_high);
    
    property p_dir_low;
        @(posedge clk) dir == 1'b0 |=> pin === 1'bz;
    endproperty
    assert property(p_dir_low);
    
    property p_data_sync;
        @(posedge clk) dir ##1 dir |-> data_out !== pin;
    endproperty
    assert property(p_data_sync);
    
    property p_input_capture;
        @(negedge clk) dir == 1'b0 && !$isunknown(pin) |-> data_in == pin;
    endproperty
    assert property(p_input_capture);
    
    property p_output_driven;
        @(negedge clk) dir == 1'b1 && !$isunknown(data_out) |-> pin == data_out;
    endproperty
    assert property(p_output_driven);
    
    property p_invalid_state;
        @(posedge clk) !($isunknown(dir) || $isunknown(data_out)) |-> !(dir && $isunknown(pin));
    endproperty
    assert property(p_invalid_state);
endmodule