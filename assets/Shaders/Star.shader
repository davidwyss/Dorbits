shader_type spatial;
render_mode unshaded;


uniform float explosions_of_life_speed = 0.1;
uniform float explosions_of_life_range = 0.1;
uniform sampler2D noise;

void vertex() {
    float a = abs(cos(TIME*explosions_of_life_speed)) + explosions_of_life_range;
    VERTEX *= vec3(1. + fract(texture(noise, VERTEX.xz).x)/a);
}

void fragment() {
    ALBEDO = vec3(0.9, 0.8, 0.05);
    float height = texture(noise, NORMAL.xz * 1.0 ).x; //divide by the size of the PlaneMesh
    float height2 = texture(noise, NORMAL.xy * 1.0 ).y; //divide by the size of the PlaneMesh
    float height3 = texture(noise, NORMAL.yz * 1.0 ).z; //divide by the size of the PlaneMesh
    ALBEDO.r = 0.5 + 0.5 * height;
    ALBEDO.g = 0.5 * height2;
    ALBEDO.b = 0.01 * height3;
}
