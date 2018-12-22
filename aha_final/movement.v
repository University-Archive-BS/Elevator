`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:13:33 12/22/2018 
// Design Name: 
// Module Name:    movement 
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
module movement();
	
	input CLK, RST, My_Clock;	// CLK and My_Clock are rising edge, RST is falling edge
	
	input reg [2:0] interior_panel; // MSB is for 3rd floor and LSB is for 1st floor
	input reg [2:0] exterior_panel; // MSB is for 3rd floor and LSB is for 1st floor
	
	reg [1:0] present_state, next_state, my_state;
	
	output reg [1:0] engine; // 00 when engine is OFF
									 // 10 when elevator is going up
									 // 101 when elevator is going down
									 
	output reg [2:0] doors; // MSB is for 3rd floor and LSB is for 1st floor
		
	parameter [5:0] S0 = 0; // 

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
				
		endcase	
	


endmodule
