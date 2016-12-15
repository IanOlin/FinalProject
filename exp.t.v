`include "exp.v"

module testExp();
	wire[10:0] delta;
	wire slt;
	reg[10:0] xExp;
	reg[10:0] yExp;

	exp exp0(delta, slt, xExp, yExp);

	initial begin
		$display("xExp        |yExp        |slt |delta");
		xExp=10'b0000000001; yExp=10'b0000000000; #10000
		$display("%b |%b |%b   |%b", xExp, yExp, slt, delta);
		xExp=10'b0000000000; yExp=10'b0000100000; #10000
		$display("%b |%b |%b   |%b", xExp, yExp, slt, delta);
		xExp=10'b1000000000; yExp=10'b1000100000; #10000
		$display("%b |%b |%b   |%b", xExp, yExp, slt, delta);
		xExp=10'b0000000000; yExp=10'b1000100000; #10000
		$display("%b |%b |%b   |%b", xExp, yExp, slt, delta);
	end
endmodule