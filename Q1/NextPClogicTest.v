`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:06:33 03/02/2009
// Design Name:   Decode24
// Module Name:   E:/350/Lab6/Decode24/Decode24Test.v
// Project Name:  Decode24
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Decode24
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

`define STRLEN 15
module Decode24Test_v;
	initial //This initial block used to dump all wire/reg values to dump file
     begin
       $dumpfile("NextPClogicTest.vcd");
       $dumpvars(0, NextPClogicTest_v);
     end

	task passTest;
		input [3:0] actualOut, expectedOut;
		input [`STRLEN*8:0] testType;
		inout [7:0] passed;
	
		if(actualOut == expectedOut) begin $display ("%s passed", testType); passed = passed + 1; end
		else $display ("%s failed: %d should be %d", testType, actualOut, expectedOut);
	endtask
	
	task allPassed;
		input [7:0] passed;
		input [7:0] numTests;
		
		if(passed == numTests) $display ("All tests passed");
		else $display("Some tests failed");
	endtask
	
	// Inputs
	reg [63:0] CurrentPC;
	reg [63:0] SignExtImm64;
    reg Branch;
    reg ALUZero;
    reg Uncondbranch;
   	reg [7:0] passed;

	// Outputs
	wire [63:0] NextPC;

	// Instantiate the Unit Under Test (UUT)
	Decode24 uut (
		.CurrentPC(CurrentPC), 
		.SignExtImm64(SignExtImm64),
        .Branch(Branch),
        .ALUZero(ALUZero),
        .Uncondbranch(Uncondbranch),
        .NextPC(NextPC),
	);

	initial begin
		// Initialize Inputs
		in = 0;
		passed = 0;

		// Add stimulus here
		#90; in = 0; #10; passTest(out, 1, "Input 0", passed);
		#90; in = 1; #10; passTest(out, 2, "Input 1", passed);
		#90; in = 2; #10; passTest(out, 4, "Input 2", passed);
		#90; in = 3; #10; passTest(out, 8, "Input 3", passed);
		#90;
		
		allPassed(passed, 4);

	end
      
endmodule

