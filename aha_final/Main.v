`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:41:54 12/14/2018 
// Design Name: 
// Module Name:    Main 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Main();
	
	input start_star;
	input [3:0] hash; //4'b1011
	
	input reg [3:0] username_1;
	input reg [3:0] username_10;
	input reg [3:0] username_100;
	
	input reg [3:0] password_1;
	input reg [3:0] password_10;
	input reg [3:0] password_100;
	input reg [3:0] password_1000;
	
	parameter [5:0] S0 = 0, S1 = 1, S2 = 2, S3 = 3;
	
	always @ (*)
		if (start_star) 
			begin
				
			end

endmodule
