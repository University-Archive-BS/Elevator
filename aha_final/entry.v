`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:45:08 12/14/2018 
// Design Name: 
// Module Name:    entry 
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
module entry();
	
	input start_star;
	input [3:0] hash; //4'b1011
	
	input reg [3:0] username_1;
	input reg [3:0] username_10;
	input reg [3:0] username_100;
	
	input reg [3:0] password_1;
	input reg [3:0] password_10;
	input reg [3:0] password_100;
	input reg [3:0] password_1000;
	
	parameter ;
	
	always @ (*)
		if (start_star) 
			begin
				
			end
	
endmodule
