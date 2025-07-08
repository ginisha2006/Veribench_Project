module ram_dual_tb;

reg [7:0] data;
reg [5:0] read_addr, write_addr;
reg we;
reg read_clock, write_clock;
wire [7:0] q;

initial begin
    #100; // delay for setup
    write_clock = 0;
    read_clock = 0;
    we = 0;
    data = 8'h12;
    write_addr = 6'b000010;
    #10;
    write_clock = ~write_clock;
    we = 1;
    #10;
    write_clock = ~write_clock;
    we = 0;
    #100;
    read_addr = 6'b000011;
    read_clock = 1;
    #10;
    read_clock = ~read_clock;
    $monitor($time, "q = %h", q);
    #500;
    $display("Test complete");
    $finish;
end

always #5 read_clock = ~read_clock;
always #5 write_clock = ~write_clock;

endmodule