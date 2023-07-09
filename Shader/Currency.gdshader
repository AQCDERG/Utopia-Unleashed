shader_type canvas_item;
uniform bool y;
uniform float r_vertical;
uniform float g_vertical;
uniform float b_vertical;
uniform float cash_value;
void fragment() {
	COLOR.g -= cash_value/10000.0;
	if(cash_value > 10000.0)
		COLOR.r -= (cash_value - 10000.0)/10000.0;
		
	
}