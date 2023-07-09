shader_type spatial;
uniform sampler2D normalMap: source_color;
uniform float r_vertical;
void vertex() {
	VERTEX.y = sin(VERTEX.z * 1.0 + TIME) * 0.1 - 1.0;
}
void fragment() {
	ALBEDO = vec3(0.1,0.4,1);
	ROUGHNESS = 0.1;
	METALLIC = 0.4;
	ALBEDO.r += r_vertical/10.0;
	ALBEDO.g += r_vertical/10.0;
	ALBEDO.b -= r_vertical/10.0;
	NORMAL_MAP = texture(normalMap,UV * 4.0).xyz;
}