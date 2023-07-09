shader_type canvas_item;
uniform float soldier_value;

void fragment() {
	COLOR.g -= soldier_value/4.0;
	COLOR.g -= soldier_value/4.0;
	//if(science_value > 2.0)
		//COLOR.g -= (science_value - 0.5);
		
	
}