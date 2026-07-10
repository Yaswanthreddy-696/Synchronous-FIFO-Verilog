module fifo(clk,res,wr_en,rd_en,wdata,rdata,full,empty,overflow,underflow);
	
	parameter DEPTH=10;
	parameter WIDTH=32;
	parameter PNTR_WIDTH=$clog2(DEPTH);

	input clk,res,wr_en,rd_en;
	input [WIDTH-1:0] wdata;
	output reg [WIDTH-1:0] rdata;
	output reg full,empty,overflow,underflow;

	//Internal Signals
	reg wr_tggle,rd_tggle;
	reg [PNTR_WIDTH-1:0] wr_pntr;
	reg [PNTR_WIDTH-1:0] rd_pntr;

	//Memory Declaration
	reg[WIDTH-1:0] mem[DEPTH-1:0];

	integer i;

	always@(posedge clk) begin

		//Reset Operation
		if(res==1) begin
			rdata=0;
			full=0;
			empty=1;
			overflow=0;
			underflow=0;
			wr_pntr=0;
			rd_pntr=0;
			wr_tggle=0;
			rd_tggle=0;
			for(i=0;i<DEPTH;i=i+1) begin
				mem[i]=0;
			end
		end
		else begin
			//Write Operation
			if(wr_en==1) begin
				if(full==1) begin
					overflow=1;
				end
				else begin
					mem[wr_pntr]=wdata;
					if(wr_pntr==DEPTH-1) begin
						wr_tggle=~wr_tggle;
						wr_pntr=0;
					end
					else wr_pntr=wr_pntr+1;
				end
			end
			
			//Read Operation
			else if(rd_en==1) begin
				if(empty==1) begin
					underflow=1;
				end
				else begin
					overflow=0;
					rdata=mem[rd_pntr];
					if(rd_pntr==DEPTH-1) begin
						rd_tggle=~rd_tggle;
						rd_pntr=0;
					end
					else rd_pntr=rd_pntr+1;
				end
			end
		end
	end

	always@(*) begin
		
		//FIFO Full
		if((wr_pntr==rd_pntr) && (wr_tggle!=rd_tggle)) begin
			full=1;
		end
		else full=0;

		//FIFO Empty
		if((wr_pntr==rd_pntr) && (wr_tggle==rd_tggle)) begin
			empty=1;
		end
		else empty=0;
	end
endmodule
