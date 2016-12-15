//module for comparing x and y
module exp(
	output reg [10:0] delta,
	output slt,
	input[10:0] xExp,
	input[10:0] yExp
	);

	wire [10:0] xExp, yExp;
	wire signed [10:0] difference;
	assign difference = xExp - yExp;
	assign slt = difference[10];
	always @(*) begin
		if (difference[10] == 1) begin
			assign delta = yExp - xExp;
		end
		else  begin
			assign delta = xExp - yExp;
		end
	end
endmodule

// //module for setting big and little
// module bigLittle(
// 	output reg [51:0] bigFrac, 
// 	output reg [51:0] littleFrac,
// 	output reg bigSign, 
// 	output reg littleSign,
// 	output reg [10:0]
// 	output reg [10:0]
// 	)