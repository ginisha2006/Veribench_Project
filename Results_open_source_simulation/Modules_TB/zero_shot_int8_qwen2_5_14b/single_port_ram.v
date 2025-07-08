module tb_single_port_ram;
    reg [7:0] data;
    reg [5:0] addr;
    reg we, clk;
    wire [7:0] q;

    single_port_ram uut (
        .data(data),
        .addr(addr),
        .we(we),
        .clk(clk),
        .q(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize signals
        data = 8'b0;
        addr = 6'b0;
        we = 0;

        // Apply stimuli
        #20 data = 8'hAA; addr = 6'h00; we = 1; // Write operation
        #10 data = 8'hBB; addr = 6'h01; we = 1; // Write operation
        #10 data = 8'hCC; addr = 6'hFF; we = 1; // Write operation at max address
        #10 data = 8'hDD; addr = 6'h00; we = 1; // Overwrite first entry
        #10 data = 8'hEE; addr = 6'h0F; we = 1; // Write operation in middle range
        #10 we = 0; // Read mode
        #10 addr = 6'h00; // Read first entry
        #10 addr = 6'h01; // Read second entry
        #10 addr = 6'hFF; // Read last entry
        #10 addr = 6'h0F; // Read mid-range entry
        #10 $stop;
    end

    initial begin
        $monitor($time, " ns | Data = %h, Address = %h, We = %b, Clk = %b, Q = %h", data, addr, we, clk, q);
    end
endmodule