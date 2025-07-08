module tb_seven_seg_display;
    reg [3:0] data;
    wire [6:0] seg;

    seven_seg_display uut (
        .data(data),
        .seg(seg)
    );

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_seven_seg_display);

        // Test all valid inputs
        data = 4'h0; #10
        data = 4'h1; #10
        data = 4'h2; #10
        data = 4'h3; #10
        data = 4'h4; #10
        data = 4'h5; #10
        data = 4'h6; #10
        data = 4'h7; #10
        data = 4'h8; #10
        data = 4'h9; #10
        data = 4'hA; #10
        data = 4'hB; #10
        data = 4'hC; #10
        data = 4'hD; #10
        data = 4'hE; #10
        data = 4'hF; #10
        
        // Test invalid input
        data = 4'ha; #10
        data = 4'hz; #10
        data = 4'hg; #10
        
        // Edge case - max value
        data = 4'hf; #10
        
        // Corner case - min value
        data = 4'h0; #10
        
        // Random values
        data = 4'h3; #10
        data = 4'hb; #10
        data = 4'hc; #10
        data = 4'he; #10
        data = 4'hd; #10
        
        // End simulation
        $finish;
    end
    
    initial begin
        $monitor($time," ns | Data = %h -> Seg = %b", data, seg);
    end
endmodule