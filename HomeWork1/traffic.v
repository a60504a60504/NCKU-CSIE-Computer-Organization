`timescale 1ns/10ps
module traffic_light (clk,rst,pass,R,G,Y);
input clk , rst , pass ;
output  R,G,Y;

reg [11:0] count = 0, nextcount = 1;
reg  R,G,Y;
reg [2:0] state, nextstate;
parameter Green1=3'b000, Green2=3'b010, Green3=3'b100, Yellow1=3'b101, Red1=3'b110;
parameter None1=3'b001, None2=3'b011;
parameter cycle1024='d1024, cycle512='d512, cycle128='d128;



always @(posedge clk or rst or pass)
begin
	if(rst == 1'b1) 
	begin
		state <= Green1;
		count <= 0;
	end
	else 
	begin 
		state <= nextstate;
		count <= nextcount;
	end
end		


//Next State Logic
always@(pass or state or count)
begin
	if (pass == 1'b1)
	begin
		if (state == Green1)
		begin
			nextstate <= Green1;
			nextcount <= count;
		end
		else 
		begin
			nextstate <= Green1;
			nextcount <= 1;
		end
	end
	else
	begin
		case(state)
		Green1: 
		begin
			if(count < cycle1024)
			begin 
				nextstate <= Green1; 
				nextcount <= count+1;
			end
			else
			begin
				nextstate <= None1; 
				nextcount <= 1;
			end
		end
		None1: 
		begin
			if(count < cycle128)
			begin 
				nextstate <= None1; 
				nextcount <= count+1;
			end
			else
			begin
				nextstate <= Green2; 
				nextcount <= 1;
			end
		end
		Green2: 
		begin
			if(count < cycle128)
			begin 
				nextstate <= Green2;
				nextcount <= count+1;
			end
			else
			begin
				nextstate <= None2;
				nextcount <= 1;
			end
		end
		None2: 
		begin
			if(count < cycle128)
			begin 
				nextstate <= None2;
				nextcount <= count+1;
			end
			else
			begin
				nextstate <= Green3;
				nextcount <= 1;
			end
		end
		Green3: 
		begin
			if(count < cycle128)
			begin 
				nextstate <= Green3;
				nextcount <= count+1;
			end
			else
			begin
				nextstate <= Yellow1;
				nextcount <= 1;
			end
		end
		Yellow1: 
		begin
			if(count < cycle512)
			begin 
				nextstate <= Yellow1;
				nextcount <= count+1;
			end
			
			else
			begin
				nextstate <= Red1;
				nextcount <= 1;
			end
		end
		Red1: 
		begin
			if(count < cycle1024)
			begin 
				nextstate <= Red1;
				nextcount <= count+1;
			end
			
			else
			begin
				nextstate <= Green1;
				nextcount <= 1;
			end
		end
		endcase
	end
end

//Output Logic
always @(state)
begin
  case(state)
      Green1:
	  	begin G<=1'b1; Y<=1'b0; R<=1'b0; end
      None1:
	  	begin G<=1'b0; Y<=1'b0; R<=1'b0; end
      Green2:
	  	begin G<=1'b1; Y<=1'b0; R<=1'b0; end
      None2:
	  	begin G<=1'b0; Y<=1'b0; R<=1'b0; end
      Green3:
	  	begin G<=1'b1; Y<=1'b0; R<=1'b0; end
      Yellow1:
	  	begin G<=1'b0; Y<=1'b1; R<=1'b0; end
      Red1:
	  	begin G<=1'b0; Y<=1'b0; R<=1'b1; end
      endcase
end


initial begin
  $dumpfile("traffic_light.VCD");
  $dumpvars;
end
endmodule