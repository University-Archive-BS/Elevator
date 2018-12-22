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
module movement(engine, doors, CLK, RST, My_Clock, interior_panel, exterior_panel);
	
	input CLK, RST, My_Clock;	// CLK and My_Clock are rising edge, RST is falling edge
	
	input [2:0] interior_panel; // MSB is for 3rd floor and LSB is for 1st floor
	input [2:0] exterior_panel; // MSB is for 3rd floor and LSB is for 1st floor
	
	reg [2:0] requests; // MSB is for 3rd floor and LSB is for 1st floor
	
	reg [1:0] present_state, next_state, my_state;
	
	reg direction; // 1 for up and 0 for down
		
	output reg [1:0] engine; // 00 when engine is OFF
									 // 10 when elevator is going up
									 // 11 when elevator is going down
									 
	output reg [2:0] doors; // MSB is for 3rd floor and LSB is for 1st floor
									// 0 is for close and 1 is for open
		
	parameter [5:0] S0 = 0, // when we are in the 1st floor and the door is open
						 S1 = 1, // when we are moving up beside the 2nd floor and the door is close
						 S2 = 2, // when we are in the 2nd floor and the door is open
						 S3 = 3, // when we are moving down beside the 2nd floor and the door is close
						 S4 = 4; // when we are in the 3rd floor and the door is open
						  

	always @ (posedge CLK or negedge RST)
      if (~RST)
		begin
			present_state <= S0;
			engine = 0;	
			doors[0] = 1;
			doors[1] = 0;
			doors[2] = 0;
		end
      else 
			present_state <= next_state;

	always @ (posedge My_Clock)
		next_state <= my_state;
      	
	always @ (interior_panel or exterior_panel)
		if (interior_panel[0] == 1 || exterior_panel[0] == 1)
			if (present_state != S0)
				requests[0] = 1;
		else if (interior_panel[1] == 1 || exterior_panel[1] == 1)
			if (present_state != S2)
				requests[1] = 1;
		else if (interior_panel[2] == 1 || exterior_panel[2] == 1)
			if (present_state != S4)
				requests[2] = 1;
				
	always @ (present_state or requests)
		case (present_state)
			S0:
				if (requests[0] == 1)
				begin
					requests[0] = 0;	
					if (requests[1] == 1 || requests[2] == 1)
					begin
						direction = 1;
						engine = 2;
						doors[0] = 0;
						my_state <= S1;
					end
				end
				
				else if (requests[1] == 1 || requests[2] == 1)
				begin
						direction = 1;
						engine = 2;
						doors[0] = 0;
						my_state <= S1;
				end
				
				else
					engine = 0;	
				
			S1: 
				if (requests[1] == 1)
				begin
					my_state <= S2;
					doors[1] = 1;
					requests[1] = 0;
				end
				
				else
				begin
					my_state <= S4;
					doors[2] = 1;
					requests[2] = 0;
				end
				
			S2: 
				if (requests[1] == 1)
				begin
					requests[1] = 0;
					if (direction == 1)
						if (requests[2] == 1)
						begin
							doors[1] = 0;
							my_state <= S4;
							doors[2] = 1;
							requests[2] = 0;
						end
						
						else if (requests[0] == 1)
						begin 
							direction = 0;
							engine = 3;
						end
						
						else
							engine = 0;	
							
					else					
						if (requests[0] == 1)
						begin
							doors[1] = 0;
							my_state <= S0;
							doors[0] = 1;
							requests[0] = 0;
						end	

						else if (requests[2] == 1)
						begin 
							direction = 1;
							engine = 2;
						end
						
						else
							engine = 0;
				end
					
				else
					
					if (direction == 1)
						if (requests[2] == 1)
						begin
							doors[1] = 0;
							my_state <= S4;
							doors[2] = 1;
							requests[2] = 0;
						end
						
						else if (requests[0] == 1)
						begin 
							direction = 0;
							engine = 3;
						end
						
						else
							engine = 0;	
							
					else
						if (requests[0] == 1)
						begin
							doors[1] = 0;
							my_state <= S0;
							doors[0] = 1;
							requests[0] = 0;
						end	

						else if (requests[2] == 1)
						begin 
							direction = 1;
							engine = 2;
						end
						
						else
							engine = 0;
				
			S3:
				if (requests[1] == 1)
				begin
					my_state <= S2;
					doors[1] = 1;
					requests[1] = 0;
				end
				
				else
				begin
					my_state <= S0;
					doors[0] = 1;
					requests[0] = 0;
				end
				
			S4:
				if (requests[2] == 1)
				begin
					requests[2] = 0;	
					if (requests[1] == 1 || requests[0] == 1)
					begin
						direction = 0;
						engine = 3;
						doors[2] = 0;
						my_state <= S3;
					end
				end
				
				else if (requests[1] == 1 || requests[0] == 1)
				begin
					direction = 0;
					engine = 3;
					doors[2] = 0;
					my_state <= S3;
				end
				
				else
					engine = 0;
				
		endcase	
	
endmodule
