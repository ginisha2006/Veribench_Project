module tb_ram_dual;

parameter CLOCK_PERIOD = 10; // in ns

reg clk_write, clk_read;
wire [7:0] data_in;
wire [5:0] addr_read, addr_write;
wire [7:0] q_out;

ram_dual #(.CLOCK_PERIOD(CLOCK_PERIOD)) dut (
   .data(data_in),
   .read_addr(addr_read),
   .write_addr(addr_write),
   .we(clk_write &&!clk_read), // ensure writes happen before reads
   .read_clock(clk_read),
   .write_clock(clk_write),
   .q(q_out)
);

initial begin
    clk_write = 0;
    clk_read = 0;
    data_in = 8'h00;
    addr_read = 6'h00;
    addr_write = 6'h00;
    repeat(10) @(posedge clock); // warm-up period
    for (int i = 0; i < 64; i++) begin
        if (i % 2 == 0) begin
            clk_write = 1;
            addr_write = i;
            data_in = i % 256;
            @(posedge clock);
            clk_write = 0;
            @(posedge clock);
        end else begin
            clk_read = 1;
            addr_read = i;
            @(posedge clock);
            clk_read = 0;
            @(posedge clock);
        end
    end
    $monitor($time, "addr_write=%b, addr_read=%b, data_in=%h, q_out=%h", addr_write, addr_read, data_in, q_out);
end

always #CLOCK_PERIOD clk_write = ~clk_write;
always #CLOCK_PERIOD clk_read = ~clk_read;

endmodule