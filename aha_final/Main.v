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
	
	input CLK, RST;	//rising edge

	input reg [3:0] BCD_input;
	// * --> 1011 --> 11
	// # --> 1100 --> 12
	
	reg [1:0] present_state, next_state;
		
	parameter [5:0] S0 = 0, // ready to work and if get * will go to S1
						 S1 = 1, // got * and now is ready to get the first digit of the username
						 S2 = 2, // ready to get the second digit of the username
						 S3 = 3, // ready to get the third digit of the username
						 S4 = 4; // got the username completely and now will check wheather it 


	always @ (posedge CLK or posedge RST)
      if (RST)
			present_state <= S0;
      else 
			present_state <= next_state; 
	
	always @ (BCD_input)
		case (present_state)
			S0:
				if (BCD_input == 4'b1011)
					next_state <= S1;
			S1:
				if (BCD_input < 4'b1010)
					next_state <= S2;
			S2: 
				if (BCD_input < 4'b1010)
					next_state <= S3;
			S3: 
				if (BCD_input < 4'b1010)
					next_state <= S4;	
		endcase	

endmodule
