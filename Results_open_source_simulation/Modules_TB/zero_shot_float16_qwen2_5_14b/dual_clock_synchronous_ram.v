module tb_ram_dual;

    reg [7:0] data;
    reg [5:0] read_addr, write_addr;
    reg we, read_clock, write_clock;
    wire [7:0] q;

    ram_dual dut (
        .data(data),
        .read_addr(read_addr),
        .write_addr(write_addr),
        .we(we),
        .read_clock(read_clock),
        .write_clock(write_clock),
        .q(q)
    );

    initial begin
        // Initialize signals
        read_clock = 0; write_clock = 0;
        data = 8'b0; read_addr = 6'b0; write_addr = 6'b0; we = 0;

        #10 read_clock = 1; write_clock = 1;
        
        // Write operation
        #20 data = 8'hAA; write_addr = 6'h0F; we = 1;
        #10 we = 0;
        
        // Read operation
        #20 read_addr = 6'h0F;
        #10 read_clock = ~read_clock;
        
        // Edge case - simultaneous read/write on same address
        #20 data = 8'hBB; write_addr = 6'h0F; we = 1; read_addr = 6'h0F;
        #10 we = 0;
        
        // Corner case - wrap around addresses
        #20 data = 8'hCC; write_addr = 6'hFF; we = 1;
        #10 we = 0;
        #20 read_addr = 6'hFF;
        #10 read_clock = ~read_clock;
        
        // Final check after reset
        #20 read_addr = 6'h0F;
        #10 read_clock = ~read_clock;
        
        // End simulation
        #10 $finish;
    end
    
    always #5 read_clock = ~read_clock;
    always #10 write_clock = ~write_clock;

    initial begin
        $dumpfile("tb_ram_dual.vcd");
        $dumpvars(0, tb_ram_dual);
    end

    initial begin
        $monitor($time, " ns: Data = %h, Read Addr = %b, Write Addr = %b, We = %b, Q = %h", data, read_addr, write_addr, we, q);
    end

endmodule