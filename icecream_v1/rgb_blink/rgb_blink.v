module rgb_blink(
	input clk_50m,
	output [2:0]led_n,
);

reg [27:0]counter;
wire [2:0]led;

always @(posedge clk_50m)
	counter <= counter + 1;

assign led[0] = counter[26] & counter[25];
assign led[1] = counter[26] & ~counter[25];
assign led[2] = ~counter[26] & counter[25];

SB_RGBA_DRV #(
	.RGB0_CURRENT("0b000001"),
	.RGB1_CURRENT("0b000001"),
	.RGB2_CURRENT("0b000001")
) rgb_driver(
	.RGBLEDEN(1),
	.CURREN(1),
	.RGB0PWM(led[0]),
	.RGB1PWM(led[1]),
	.RGB2PWM(led[2]),
	.RGB0(led_n[0]),
	.RGB1(led_n[1]),
	.RGB2(led_n[2])
);

endmodule
