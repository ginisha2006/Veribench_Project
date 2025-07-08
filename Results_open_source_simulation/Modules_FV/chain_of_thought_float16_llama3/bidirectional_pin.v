module tb_bidir_pin;
    parameter WIDTH = 1;
    logic [WIDTH-1:0] pin;
    logic dir;
    logic [WIDTH-1:0] data_out;
    logic [WIDTH-1:0] data_in;

    bidir_pin dut (
       .pin(pin),
       .dir(dir),
       .data_out(data_out),
       .data_in(data_in)
    );

    always begin
        dir = 0;
        #10 dir = 1;
        #20 dir = 0;
    end

    property p_dir_set;
        @(posedge dir) disable iff (!dir) dir == 1'b0 |-> pin == {WIDTH{1'bz}};
    endproperty

    property p_dir_clr;
        @(negedge dir) disable iff (dir) dir == 1'b1 |-> pin == {WIDTH{1'bz}};
    endproperty

    property p_data_out;
        @(posedge dir) disable iff (!dir) data_out == pin;
    endproperty

    property p_data_in;
        @(negedge dir) disable iff (dir) data_in == pin;
    endproperty

    assert property (p_dir_set);
    assert property (p_dir_clr);
    assert property (p_data_out);
    assert property (p_data_in);

endmodule