module tb_seven_seg_display;
// Parameter
parameter DATA_WIDTH = 4;  // Default data width is 4 bits
// Input
reg [DATA_WIDTH-1:0] data;
// Output
wire [6:0] seg;
// Instantiate the Seven Segment Display
seven_seg_display #(.DATA_WIDTH(DATA_WIDTH)) uut (
   .data(data), 
   .seg(seg)
);
initial begin
    // Display the header for the output
    $display("Time	data	seg");
    // Monitor changes to input and output
    $monitor("%0d	%b	%b", $time, data, seg);
    // Test Case 1: Display '0'
    data = 4'h0; #10;
    // Test Case 2: Display '1'
    data = 4'h1; #10;
    // Test Case 3: Display '2'
    data = 4'h2; #10;
    // Test Case 4: Display '3'
    data = 4'h3; #10;
    // Test Case 5: Display '4'
    data = 4'h4; #10;
    // Test Case 6: Display '5'
    data = 4'h5; #10;
    // Test Case 7: Display '6'
    data = 4'h6; #10;
    // Test Case 8: Display '7'
    data = 4'h7; #10;
    // Test Case 9: Display '8'
    data = 4'h8; #10;
    // Test Case 10: Display '9'
    data = 4'h9; #10;
    // Test Case 11: Display 'A'
    data = 4'hA; #10;
    // Test Case 12: Display 'B'
    data = 4'hB; #10;
    // Test Case 13: Display 'C'
    data = 4'hC; #10;
    // Test Case 14: Display 'D'
    data = 4'hD; #10;
    // Test Case 15: Display 'E'
    data = 4'hE; #10;
    // Test Case 16: Display 'F'
    data = 4'hF; #10;
    // Test Case 17: Invalid input
    data = 4'ha; #10;
    // Finish the simulation
    $finish;
end
endmodule