shader_type spatial;
render_mode unshaded;


uniform sampler2D noise;

void vertex() {
    float a = 10.;
    VERTEX *= vec3(1. + fract(texture(noise, VERTEX.xz).x)/a);
}

void fragment() {
    vec3 world_pos = (CAMERA_MATRIX * vec4(VERTEX, 1.0)).xyz;
    ALBEDO = vec3(0.9, 0.8, 0.02);
    vec2 col = texture(noise, world_pos.xy).yz; //divide by the size of the PlaneMesh
    ALBEDO.r = 0.5 + 0.5 * col.x;
    ALBEDO.g = 0.5 * col.y;
}
