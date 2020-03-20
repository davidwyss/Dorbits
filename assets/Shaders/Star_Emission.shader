shader_type spatial;
render_mode unshaded;

uniform float size;
uniform sampler2D noise;

void fragment() {
    float height = texture(noise, NORMAL.xz / size ).x; //divide by the size of the PlaneMesh
    ALBEDO.r = 0.75 + 0.25 * height;
    ALBEDO.g = 0.1 * height;
    ALBEDO.b = 0.001 * height;
    ALBEDO *= 0.6; 
    
    
    
}
