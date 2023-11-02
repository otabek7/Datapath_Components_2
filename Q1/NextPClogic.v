module NextPClogic(NextPC, CurrentPC, SignExtImm64, Branch, ALUZero, Uncondbranch); 
	input [63:0] CurrentPC, SignExtImm64;
	input Branch, ALUZero, Uncondbranch;
	output [63:0] NextPC;

	always@(*) begin
		if (Branch) begin
			if(ALUZero) NextPC <= CurrentPC + (SignExtImm64 << 2);
			else NextPC <= CurrentPC + 4;
		end
		else if (Uncondbranch) begin
			NextPC <= CurrentPC + SignExtImm64;
		end
		else NextPC <= CurrentPC + 4;
	end
endmodule
