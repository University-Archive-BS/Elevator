`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:12:13 12/22/2018 
// Design Name: 
// Module Name:    management 
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
module management();

	input CLK, RST, My_Clock;	// CLK and My_Clock are rising edge, RST is falling edge

	input reg [3:0] BCD_input;
	// 0  to 9 BCDs are for numeric inputs digit by digit
	// *  --> 1011 --> 11
	// #  --> 1100 --> 12
	// *# --> 1101 --> 13
	
	reg [1:0] present_state, next_state, my_state;
	
	reg [11:0] username_admin = 12'b000100100000; // 120
	reg [15:0] password_admin = 16'b0001010000000000; // 1400
	
	reg [11:0] username_temp;
	reg [15:0] password_temp;
		
	parameter [5:0] S0 = 0, // ready to work and if get * will go to S1
						 S1 = 1, // got * and now is ready to get the first digit of the username
						 S2 = 2, // ready to get the second digit of the username
						 S3 = 3, // ready to get the third digit of the username
						 S4 = 4, // got the username completely and now check whether we have it or no
						 S5 = 5, // got the username completely and now detected as simple user and ready to get the first digit of the password of simple user
						 S6 = 6, // ready to get the second digit of the password of simple user
						 S7 = 7, // ready to get the third digit of the password of simple user
						 S8 = 8, // ready to get the fourth digit of the password of simple user
						 S9 = 9, // got the username completely and now detected as admin and ready to get the first digit of the password of admin
						 S10 = 10, // ready to get the second digit of the password of admin
						 S11 = 11, // ready to get the third digit of the password of admin
						 S12 = 12; // ready to get the fourth digit of the password of admin


	always @ (posedge CLK or negedge RST)
      if (~RST)
			present_state <= S0;
      else 
			present_state <= next_state;

	always @ (posedge My_Clock)
		next_state <= my_state;
      	
	always @ (BCD_input)
		case (present_state)
			S0:
				if (BCD_input == 4'b1011)
					my_state <= S1;
			S1:
				if (BCD_input < 4'b1010) // get the first digit of the username
				begin
					my_state <= S2;
					username_temp[11:8] <= BCD_input;
				end
			S2: 
				if (BCD_input < 4'b1010) // get the second digit of the username
				begin
					my_state <= S3;
					username_temp[7:4] <= BCD_input;
				end
			S3: 
				if (BCD_input < 4'b1010) // get the third digit of the username
				begin				
					username_temp[3:0] <= BCD_input;
					if (username_admin == username_temp) // here we check whether the user is valid or not
						my_state <= S4;
					else
						my_state <= S0;
				end
			S4:
				if (BCD_input == 4'b1011) // get * or *#
					my_state <= S6; // login as admin
				else if (BCD_input == 4'b1101)
					my_state <= S5; // login as simple user
				else
					my_state <= S0;
			S5:
				if (BCD_input < 4'b1010)
					my_state <= S6; // simple user first digit password
			S6:
				if (BCD_input < 4'b1010)
					my_state <= S7; // simple user second digit password
			S7:
				if (BCD_input < 4'b1010)
					my_state <= S8; // simple user third digit password
			//S8:
				//if (BCD_input < 4'b1010)
					//my_state <= S1; TODO // simple user fourth digit password
			S9:
				if (BCD_input < 4'b1010)
					my_state <= S10; // admin first digit password
			S10:
				if (BCD_input < 4'b1010)
					my_state <= S11; // admin second digit password
			S11:
				if (BCD_input < 4'b1010)
					my_state <= S12; // admin third digit password
			//S12:
				//if (BCD_input < 4'b1010)
					//my_state <= S; TODO // admin fourth digit password
				
		endcase	


endmodule
