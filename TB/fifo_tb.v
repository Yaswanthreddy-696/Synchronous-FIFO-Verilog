`include "fifo.v"
module tb;
	
	parameter DEPTH=4;
	parameter WIDTH=32;
	parameter PNTR_WIDTH=$clog2(DEPTH);
	
	reg clk,res,wr_en,rd_en;
	reg [WIDTH-1:0] wdata;
	wire [WIDTH-1:0] rdata;
	wire full,overflow,empty,underflow;
	
	fifo #(.DEPTH(DEPTH),.WIDTH(WIDTH),.PNTR_WIDTH(PNTR_WIDTH)) dut(.clk(clk),.res(res),.wr_en(wr_en),.rd_en(rd_en),.wdata(wdata),.rdata(rdata),.full(full),.empty(empty),.overflow(overflow),.underflow(underflow));


	task write(input integer n);
		begin
			repeat(n) begin
				@(posedge clk);
				wr_en=1;
				wdata=$urandom_range(1,30);
				@(posedge clk);
				wr_en=0;
				wdata=0;
			end
		end
	endtask

	task read(input integer n);
		begin
			repeat(n) begin
				@(posedge clk)
				rd_en=1;
				@(posedge clk)
				rd_en=0;
			end
		end
	endtask

	always #5  clk=~clk;

	initial begin
		clk=0;
		res=1;
		wdata=0;
		wr_en=0;
		rd_en=0;
		repeat(2)@(posedge clk);
		res=0;
		write(DEPTH);     //Full Condition
		read(DEPTH);     //Empty Condition
		write(DEPTH+1); //Overflow Condition
		read(DEPTH+1); //Underflow Condition
	end

	initial begin
		#500;
		$finish;
	end
endmodule
