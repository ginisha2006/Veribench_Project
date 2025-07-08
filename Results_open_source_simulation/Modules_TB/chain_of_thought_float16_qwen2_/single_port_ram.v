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

        // Stimulus
        #10 data = 8'hAA; addr = 6'h00; we = 1; // Write operation at address 0
        #10 data = 8'hBB; addr = 6'h01; we = 1; // Write operation at address 1
        #10 data = 8'hCC; addr = 6'h02; we = 1; // Write operation at address 2
        #10 data = 8'hDD; addr = 6'h03; we = 1; // Write operation at address 3
        #10 we = 0; // No write operation
        #10 addr = 6'h00; we = 0; // Read from address 0
        #10 addr = 6'hFF; we = 0; // Attempt read with invalid address
        #10 addr = 6'h01; we = 0; // Read from address 1
        #10 addr = 6'h02; we = 0; // Read from address 2
        #10 addr = 6'h03; we = 0; // Read from address 3
        #10 addr = 6'h40; we = 1; // Write beyond valid range
        #10 $finish;
    end

    always @(posedge clk) begin
        if (we == 1) $display("Write %h to Address %h", data, addr);
        else $display("Read %h from Address %h", q, addr);
    end
endmodule