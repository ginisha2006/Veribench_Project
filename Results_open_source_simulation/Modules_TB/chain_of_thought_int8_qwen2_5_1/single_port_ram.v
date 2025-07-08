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

        // Test write operation
        #10 data = 8'hAA; addr = 6'h00; we = 1; 
        #10 data = 8'hBB; addr = 6'h0F; we = 1; 

        // Read back written values
        #10 we = 0; addr = 6'h00; 
        #10 addr = 6'h0F; 
        
        // Edge case - out-of-bounds address
        #10 addr = 6'h40; we = 1; data = 8'hCC; 
        #10 addr = 6'hFF; we = 1; data = 8'hDD; 

        // Corner case - continuous writes
        for(int i=0; i<10; i=i+1) begin
            #10 data = {i,i}; addr = i; we = 1; 
        end
        
        // Continuous reads after writes
        for(int i=0; i<10; i=i+1) begin
            #10 addr = i; we = 0; 
        end

        // Final check
        #10 addr = 6'h00; 
        #10 addr = 6'h0F; 
        #10 addr = 6'h40; 
        #10 addr = 6'hFF; 

        // End simulation
        #10 $finish;
    end

    always @(posedge clk) begin
        if (we) $display("Write %h at address %h", data, addr);
        else $display("Read %h from address %h", q, addr);
    end
endmodule