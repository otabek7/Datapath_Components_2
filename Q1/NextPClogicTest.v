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
module NextPClogicTest_v;
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
	NextPClogic uut (
		.CurrentPC(CurrentPC), 
		.SignExtImm64(SignExtImm64),
        .Branch(Branch),
        .ALUZero(ALUZero),
        .Uncondbranch(Uncondbranch),
        .NextPC(NextPC)
	);

	initial begin
		// Initialize Inputs
		CurrentPC = 0;
		SignExtImm64 = 2;
        passed=0;

        Branch = 0;
        ALUZero=0;
        Uncondbranch=0;
   	    // Branch is true if the current instruction is a conditional branch instruction.
        // Uncond branch is true if the current instruction is a Uncond branch instruction

		// Add stimulus here
		#90; Branch = 0; Uncondbranch = 0; ALUZero = 0; #10; passTest(NextPC, 4, "Input 0", passed);
		#90; Branch = 0; Uncondbranch = 0; ALUZero = 1; #10; passTest(NextPC, 4, "Input 1", passed);

		#90; Branch = 0; Uncondbranch = 1; ALUZero = 0; #10; passTest(NextPC, 4, "Input 2", passed);
		#90; Branch = 0; Uncondbranch = 1; ALUZero = 1; #10; passTest(NextPC, 4'b1000, "Input 3", passed);
		
        #90; Branch = 1; Uncondbranch = 0; ALUZero = 0; #10; passTest(NextPC, 4, "Input 4", passed);
		#90; Branch = 1; Uncondbranch = 0; ALUZero = 1; #10; passTest(NextPC, 4'b1000, "Input 5", passed);
		
        #90; Branch = 1; Uncondbranch = 1; ALUZero = 0; #10; passTest(NextPC, 4, "Input 6", passed);
		#90; Branch = 1; Uncondbranch = 1; ALUZero = 1; #10; passTest(NextPC, 4'b1000, "Input 7", passed);

		#90;
		
		allPassed(passed, 8);

	end
      
endmodule

