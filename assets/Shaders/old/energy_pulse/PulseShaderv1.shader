shader_type canvas_item;

uniform float EXPANSION_SPEED = 1.;
uniform float WAVE_SIZE = 3.;
uniform float WAVE_MAX_EXPANSION = 2.;
uniform vec3 WAVE_COLOR = vec3(1.);


void fragment() {
    vec2 uv = UV;
    vec3 color = WAVE_COLOR;
    vec2 center = vec2(0.5);
//    vec2 center = vec2(sin(TIME)*0.2 + 0.5,sin(TIME)*0.2+0.5);
    float dist = distance(center,uv);
    float time = TIME*EXPANSION_SPEED;
    time += step(1., mod(dist*16.,4.0)) * 0.125;
    float start = fract(time)*WAVE_MAX_EXPANSION;
    
    color.r -= abs(dist-start)*WAVE_SIZE;

    COLOR.rgb = color;
//    float max_intensity_range = fract(TIME * 0.1);
//    float max_intensity_range = 0.2;
//    float dist = distance(uv,center); 
//    float val = max_intensity_range-uv;
    
}