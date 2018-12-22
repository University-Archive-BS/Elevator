`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:33:11 12/22/2018
// Design Name:   movement
// Module Name:   F:/Courses/Aha_Final_Project/aha_final/movement_testbench.v
// Project Name:  aha_final
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: movement
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module movement_testbench;
	
	// Inputs
	reg CLK, RST, My_Clock;	
	reg [2:0] interior_panel, exterior_panel;
				
	// Outputs
	wire [1:0] engine;
	wire [2:0] doors;

	// Instantiate the Unit Under Test (UUT)
	movement uut (
		.engine(engine), 
		.doors(doors), 
		.CLK(CLK), 
		.RST(RST), 
		.My_Clock(My_Clock),
		.interior_panel(interior_panel), 
		.exterior_panel(exterior_panel)
	);

	initial
	begin
		RST = 0;
		CLK = 0;
	#15 RST = 1;
		repeat (30)
		#25 CLK = ~CLK;
	end
	
	initial
	begin
		My_Clock = 0;
		exterior_panel = 0;
		interior_panel = 0;
		#25 interior_panel = 3'b010;
		#25 My_Clock = 1;
		#15 interior_panel = 0;
		
		
	end

endmodule

