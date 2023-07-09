shader_type spatial;
uniform float hpChange;
void fragment() {
	ALBEDO.r += hpChange;
}
