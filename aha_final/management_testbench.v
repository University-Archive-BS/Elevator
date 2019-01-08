`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
// Create Date:   19:25:53 01/04/2019
// Design Name:   management
// Module Name:   F:/Courses/Aha_Final_Project/aha_final/management_testbench.v
// Project Name:  aha_final 
// Verilog Test Fixture created by ISE for module: management
// Revision 0.01 - File Created
////////////////////////////////////////////////////////////////////////////////
module management_testbench;

	// Inputs
	reg CLK;
	reg RST;
	reg my_clock;
	reg [4:1] BCD_input;

	// Instantiate the Unit Under Test (UUT)
	management uut (
		.CLK(CLK), 
		.RST(RST), 
		.my_clock(my_clock), 
		.BCD_input(BCD_input)
	);

	initial 
	begin
		RST = 0;
		CLK = 0;
	#5 RST = 1;
	#5 RST = 0;
		repeat (100)
	#10 CLK = ~CLK;
	end
	
	initial
	begin
		 my_clock = 0;
		 BCD_input = 4'b0000;
	#5	 BCD_input = 4'b1011;
	#10 my_clock = ~my_clock;
	#5	 BCD_input = 4'b0000;
	#5  my_clock = ~my_clock;
	#5  my_clock = ~my_clock;
	#5  BCD_input = 4'b0001;
	    BCD_input = 4'b0000;
	#5  my_clock = ~my_clock;
	#5  my_clock = ~my_clock;
	#5 BCD_input = 4'b0001;
	#5  my_clock = ~my_clock;
		
	end
      
endmodule

