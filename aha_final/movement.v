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
module movement(engine, doors, CLK, RST, interior_panel, exterior_panel);
	
	input CLK, RST;	// CLK is rising edge, RST is falling edge
	
	input [2:0] interior_panel; // MSB is for 3rd floor and LSB is for 1st floor
	input [2:0] exterior_panel; // MSB is for 3rd floor and LSB is for 1st floor
	
	reg [2:0] requests = 0; // MSB is for 3rd floor and LSB is for 1st floor
	
	reg [5:0] present_state = 0, next_state = 0;
	
	reg direction; // 1 for up and 0 for down
		
	output reg [1:0] engine; // 00 when engine is OFF
									 // 10 when elevator is going up
									 // 11 when elevator is going down
									 
	output reg [2:0] doors; // MSB is for 3rd floor and LSB is for 1st floor
									// 0 is for close and 1 is for open
		
	parameter [5:0] S0 = 6'b000000, // when we are in the 1st floor and the door is open
						 S1 = 6'b000001, // when we are moving up beside the 2nd floor and the door is close
						 S2 = 6'b000010, // when we are in the 2nd floor and the door is open
						 S3 = 6'b000011, // when we are moving down beside the 2nd floor and the door is close
						 S4 = 6'b000100; // when we are in the 3rd floor and the door is open
						  

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
		begin
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
						next_state <= S1;
					end
				end
				
				else if (requests[1] == 1 || requests[2] == 1)
				begin
						direction = 1;
						engine = 2;
						doors[0] = 0;
						next_state <= S1;
				end
				
				else
					engine = 0;	
				
			S1: 
				if (requests[1] == 1)
				begin
					next_state <= S2;
					doors[1] = 1;
					requests[1] = 0;
				end
				
				else if (requests[2] == 1)
				begin
					next_state <= S4;
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
							next_state <= S4;
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
							next_state <= S0;
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
							next_state <= S4;
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
							next_state <= S0;
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
					next_state <= S2;
					doors[1] = 1;
					requests[1] = 0;
				end
				
				else
				begin
					next_state <= S0;
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
						next_state <= S3;
					end
				end
				
				else if (requests[1] == 1 || requests[0] == 1)
				begin
					direction = 0;
					engine = 3;
					doors[2] = 0;
					next_state <= S3;
				end
				
				else
					engine = 0;
				
			endcase
			present_state <= next_state;
		end
      	
	always @ (posedge interior_panel[0] or posedge exterior_panel[0])
		requests[0] = 1;
	
	always @ (posedge interior_panel[1] or posedge exterior_panel[1])
		requests[1] = 1;
		
	always @ (posedge interior_panel[2] or posedge exterior_panel[2])
		requests[2] = 1;
			
endmodule
