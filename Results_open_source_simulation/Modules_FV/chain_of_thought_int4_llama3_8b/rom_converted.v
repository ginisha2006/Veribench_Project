module tb_rom_simple;
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;
    logic clk;
    logic rst_n;
    logic [ADDR_WIDTH-1:0] addr;
    logic [DATA_WIDTH-1:0] data_out;
    rom_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (
       .addr(addr),
       .data_out(data_out)
    );

    always @(*) begin assert (@(posedge clk) disable iff (!rst_n) data_out == mem[dut.addr]); end
    always @(*) begin assert (@(negedge clk) disable iff (!rst_n) dut.data_out === dut.mem[dut.addr]); end
    always @(*) begin assert (($onehot(dut.addr))); end
    assert property (~p_overflow);
    assert property (~p_underflow);

    always #10 clk = ~clk;
    initial begin
        rst_n = 1'b0;
        repeat (10) @ (posedge clk);
        rst_n = 1'b1;
    end
endmodule