`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/02/10 21:15:15
// Design Name: 
// Module Name: counter
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


module counter #(  
    parameter int WIDTH = 8
)
(
    input logic clk,
    input logic rst_n,
    input logic en,
    output logic [WIDTH-1:0] q
    );
    
    always_ff @(posedge clk) begin
        if (!rst_n)
            q <= '0;
        else if (en)
            q <= q + 1;
    end
    
endmodule
