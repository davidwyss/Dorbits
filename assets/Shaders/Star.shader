shader_type spatial;
render_mode unshaded;


uniform sampler2D noise;

void vertex() {
    float a = 10.0;
    VERTEX *= vec3(1. + fract(texture(noise, VERTEX.xz).x)/a);
}

void fragment() {
	vec3 world_pos = VERTEX;//(CAMERA_MATRIX * vec4(VERTEX, 1.0)).xyz;
    ALBEDO = vec3(1, 1, 1);
    vec2 col = texture(noise, world_pos.xy).yz; //divide by the size of the PlaneMesh
    ALBEDO.r = 1.0 * col.x;
    ALBEDO.g = 0.019 * col.y;
	ALBEDO.b = 0.854;
}
