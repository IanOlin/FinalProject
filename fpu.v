// 64 bit floating point unit By Ian Paul
`include "exp.v"

module fpu (
	output [63:0] z,
	// input op,
	input [63:0] x,
	input [63:0] y
);

	// Break the input into its parts
	wire xSign, ySign;
	assign xSign = x[63];
	assign ySign = y[63];
	wire[10:0] xExp, yExp;
	assign xExp = x[62:52];
	assign yExp = y[62:52];
	wire[51:0] xFrac, yFrac;
	assign xFrac = x[51:0];
	assign yFrac = y[51:0];

	// Find the difference in the exponents
	wire [10:0] expDelta; // magnitude of the difference between the exponents
	wire expSlt; //1 if xExp (and x) is less than yExp (and y), 0 otherwise
	exp exp0(expDelta, expSlt, xExp, yExp);

	// Group number into larger and smaller for normalizing exponents
	reg [51:0] bigFrac, littleFrac;
	reg bigSign, littleSign;
	reg [10:0] bigExp, littleExp;
	reg signed [52:0] bigSignif, littleSignif;

	// Define the components of z
	reg zSign;
	reg [10:0] zExp;
	reg [51:0] zFrac;
	reg [52:0] zSignif;

	always @(*) begin
		if (expSlt == 1) begin // case where x is less than y
			assign littleFrac = xFrac;
			assign littleExp = 	xExp; // not needed, will be equal to bigExp
			assign littleSign = xSign;
			assign bigExp = 	yExp;
			assign bigFrac = 	yFrac;
			assign bigSign = 	ySign;
		end
		else begin //case where x is equal to or greater than y
			assign littleFrac = yFrac;
			assign littleExp = 	yExp; // not needed, will be equal to bigExp
			assign littleSign = ySign;
			assign bigExp = 	xExp;
			assign bigFrac = 	xFrac;
			assign bigSign = 	xSign;
		end

		assign littleFrac = littleFrac >> expDelta;
		assign littleExp = bigExp;
		if (bigSign == 1) begin
			assign bigSignif = ~bigFrac + 53'b1;
		end
		if (bigSign == 0) begin
			assign bigSignif = bigFrac ;
		end
		if (littleSign == 1) begin
			assign littleSignif = ~littleFrac + 53'b1;
		end
		if (littleSign == 0) begin
			assign littleSignif = littleFrac;
		end
		//should be checking for overflow
		assign zSignif = littleSignif+bigSignif;
		if (zSignif[52] == 1) begin
			assign zSign = 1;
			assign zFrac = ~(zSignif[51:0]-52'b1);			
		end
		if (zSignif ==0 ) begin
			assign zSign = 0;
			assign zFrac = zSignif[51:0];
		end
		assign zExp = bigExp;
	end


	assign z = {zSign, zExp, zFrac};


endmodule