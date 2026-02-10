`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/02/10 21:26:57
// Design Name: 
// Module Name: tb_counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_counter(

    );
    
    localparam int WIDTH = 8;
    logic clk;
    logic rst_n;
    logic en;
    logic [WIDTH-1:0] q;
    
    // DUT
    counter #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .en(en),
        .q(q)
    );
    
    // clock generation (100MHz)
    initial clk = 0;
    always #5 clk = ~clk;
    
    // self-check variable
    int unsigned expected;
    
    initial begin
        // init
        rst_n = 0;
        en = 0;
        expected = 0;
        
        // reset 유지
        repeat (5) @(posedge clk);
        
        // reset release
        rst_n = 1;
        @(posedge clk);
        
        // enable on
        en = 1;
        
        // 20 cycles check
        repeat (20) begin
            @(posedge clk);
            expected = expected + 1;
            
            if (q !== expected[WIDTH-1:0]) begin
                $display("[FAIL] time=%0t q=%0d expected=%0d", $time, q, expected);
                $finish;
            end
        end
        
        // enable off (hold check)
        en = 0;
        repeat (5) begin
            @(posedge clk);
            if (q !== expected[WIDTH-1:0]) begin
                $display("[FAIL] HOLD time=%0t q=%0d expected=%0d", $time, q, expected);
                $finish;
            end
        end
        
        $display("[PASS] counter test passed!");
        $finish;
    end
       
endmodule
