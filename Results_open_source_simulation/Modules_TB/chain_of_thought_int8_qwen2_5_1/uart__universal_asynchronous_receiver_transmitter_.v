module tb_uart_module;
    reg clk;
    reg rst;
    reg rx;
    wire tx;
    reg [7:0] data_in;
    wire [7:0] data_out;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Clock period is 10 time units
    end

    uart_module uut (
        .clk(clk),
        .rst(rst),
        .rx(rx),
        .tx(tx),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        rst = 1;
        #10 rst = 0;
        
        // Send 'A' character (8'h41) through RX
        data_in = 8'h41;
        rx = 1'b1; // Start bit
        #10 rx = 1'b0;
        #10 foreach (data_in[i]) begin
            #10 rx = data_in[i];
        end
        #10 rx = 1'b1; // Stop bit
        
        // Check if correct data received on data_out
        #30 if (data_out != 8'h41) $display("Error: Incorrect data_out value %h", data_out);

        // Repeat with another character 'B' (8'h42)
        data_in = 8'h42;
        rx = 1'b1; // Start bit
        #10 rx = 1'b0;
        #10 foreach (data_in[i]) begin
            #10 rx = data_in[i];
        end
        #10 rx = 1'b1; // Stop bit
        
        // Check if correct data received on data_out
        #30 if (data_out != 8'h42) $display("Error: Incorrect data_out value %h", data_out);

        // Edge case - sending all zeros
        data_in = 8'h00;
        rx = 1'b1; // Start bit
        #10 rx = 1'b0;
        #10 foreach (data_in[i]) begin
            #10 rx = data_in[i];
        end
        #10 rx = 1'b1; // Stop bit
        
        // Check if correct data received on data_out
        #30 if (data_out != 8'h00) $display("Error: Incorrect data_out value %h", data_out);

        // Corner case - sending all ones
        data_in = 8'hFF;
        rx = 1'b1; // Start bit
        #10 rx = 1'b0;
        #10 foreach (data_in[i]) begin
            #10 rx = data_in[i];
        end
        #10 rx = 1'b1; // Stop bit
        
        // Check if correct data received on data_out
        #30 if (data_out != 8'hFF) $display("Error: Incorrect data_out value %h", data_out);

        $finish;
    end
endmodule