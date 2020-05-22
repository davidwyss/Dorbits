shader_type spatial;
render_mode unshaded;

uniform float size;
uniform sampler2D noise;

void fragment() {
    float height = texture(noise, NORMAL.xz / size ).x; //divide by the size of the PlaneMesh
    ALBEDO.r = .294 * height;
    ALBEDO.g = .968 * height;
    ALBEDO.b = .976 * height;
    ALBEDO *= .4; 
    
    
    
}
