shader_type spatial;
render_mode unshaded;

uniform sampler2D noise;

void fragment() {
    RIM = 11110.6;
    METALLIC = 0.0;
    ROUGHNESS = 0.01;
    ALBEDO = vec3(0.1, 0.3, 0.5);
}
