shader_type canvas_item;
uniform sampler2D noiseTexture: repeat_enable;

void fragment() {
	vec2 uv = vec2(UV.x + TIME/30.0, UV.y);
	COLOR = texture(noiseTexture, uv);
	
}

void vertex() {
	
}