module single_port_ram_tb();

reg [7:0] data_in;
reg [5:0] addr_in;
wire [7:0] q_out;
reg clk;
reg write_enable;

single_port_ram dut (
   .data(data_in),
   .addr(addr_in),
   .we(write_enable),
   .clk(clk),
   .q(q_out)
);

initial begin
    #100; // wait for 100 time units
    clk = 0;
    forever #5 clk = ~clk; // toggle clock at 50 MHz
end

initial begin
    $monitor($time, "addr=%b, data=08h%b, we=%b, q=08h%b", addr_in, data_in, write_enable, q_out);
    #500 $display("Simulation complete");
end

initial begin
    repeat(64) begin
        addr_in = 0;
        data_in = 8'h12;
        write_enable = 1;
        @(posedge clk); // wait for rising edge of clock
        write_enable = 0;
        repeat(3) @(posedge clk); // wait for 3 more clock cycles
        addr_in = 31;
        data_in = 8'h34;
        write_enable = 1;
        @(posedge clk); // wait for rising edge of clock
        write_enable = 0;
        repeat(4) @(posedge clk); // wait for 4 more clock cycles
    end
    repeat(128) begin
        addr_in = 32;
        data_in = 8'hz;
        write_enable = 0;
        @(posedge clk); // wait for rising edge of clock
    end
end

endmodule