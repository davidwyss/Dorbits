shader_type canvas_item;


const float PI = 3.14159265358979323846;
uniform float HP_PERCENT = 1.;


vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
    float cosa = cos(rotation);
    float sina = sin(rotation);
    uv -= pivot;
    return vec2(
        cosa * uv.x - sina * uv.y,
        cosa * uv.y + sina * uv.x 
    ) + pivot;
}




void fragment() {
    float speed=0.2;
    vec2 uv = UV;
    uv /= sin(TIME*speed);
    uv += -abs(cos(TIME*speed)*0.25);
    uv = rotateUV(uv,vec2(.5),3.141*sin(TIME*speed));
    vec2 center = vec2(0.5);
    float max_intensity_range = fract(TIME*speed);
    float dist = distance(uv,center); 
    COLOR.rgb = texture(TEXTURE, uv).rgb;
    COLOR.rgb += vec3(dist);
    COLOR.rgb -= vec3(dist)*4.;
    COLOR.gb -= vec2(0.5);
    
 
}