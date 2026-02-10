module counter_control(
	input       clk,
	input       rst_n,
	input       div_en,
	input [3:0] div_val,
	input       halt_req,
	input       timer_en,
	input       debug_mode,
	output      cnt_en
);
// Khai bao
wire default_mode; 
wire control_mode;
wire control_mode_other;
wire cnt_rst;
wire [7:0] int_cnt_nxt;
reg  [7:0] int_cnt;
reg  [7:0] limit;

assign default_mode = !div_en & timer_en  ;
assign control_mode =  div_en & timer_en & (div_val == 0);
assign control_mode_other = div_en & timer_en & (div_val != 0) & (int_cnt == limit);
assign cnt_rst = !timer_en | !div_en | (limit == int_cnt); 

always @(*)
begin
	case(div_val)
		4'b0001: limit = 1;	
		4'b0010: limit = 3;
		4'b0011: limit = 7;
		4'b0100: limit = 15;
		4'b0101: limit = 31;
		4'b0110: limit = 63;
		4'b0111: limit = 127;
		4'b1000: limit = 255;
		default: limit = 0;
	endcase	
end

assign int_cnt_nxt = halt_req ? int_cnt :
	                        cnt_rst ? 8'h0 : int_cnt + 1'b1;
always @(posedge clk or negedge rst_n)
begin
	if(!rst_n) begin
		int_cnt <= 8'h0;
	end
	else begin
		int_cnt <= int_cnt_nxt;
	end
end
assign cnt_en = (default_mode || control_mode || control_mode_other) & !halt_req ;

endmodule
