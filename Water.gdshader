shader_type spatial;
uniform sampler2D normalMap: source_color;
uniform float r_vertical;
void vertex() {
	VERTEX.y = sin(VERTEX.z * 60.0 + TIME * 2.0) * 0.3 - 1.0;
}
void fragment() {
	ALBEDO = vec3(0.1,0.4,1);
	ROUGHNESS = 0.1;
	METALLIC = 0.1;
	ALBEDO.r += r_vertical/20000.0;
	ALBEDO.g += r_vertical/20000.0;
	ALBEDO.b -= r_vertical/20000.0;
	NORMAL_MAP = texture(normalMap,UV * 5.0).xyz;
	ALPHA = -1.0;
}