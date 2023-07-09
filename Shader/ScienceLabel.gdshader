shader_type canvas_item;
uniform float science_value;
void fragment() {
	COLOR.b += science_value;
	COLOR.g -= science_value/4.0;
	//if(science_value > 2.0)
		//COLOR.g -= (science_value - 0.5);
		
	
}