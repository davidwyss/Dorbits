shader_type canvas_item;

uniform float EXPANSION_SPEED = 1.;
uniform float WAVE_SIZE = 3.;
uniform float WAVE_MAX_EXPANSION = 2.;
uniform vec3 WAVE_COLOR = vec3(1.);
uniform vec2 SPAWN = vec2(.5);
uniform vec2 SPAWN_RANDOM = vec2(.25);

float ring(float time,float dist)
{
    float start = fract(time *EXPANSION_SPEED)*WAVE_MAX_EXPANSION;
    return min(0.,.5 - abs(dist-start)*WAVE_SIZE);
}


void fragment() {
    vec2 uv = UV;
    vec3 color = WAVE_COLOR;
    vec2 center = vec2(sin(TIME)*SPAWN_RANDOM.x + SPAWN.x,sin(TIME)*SPAWN_RANDOM.y+SPAWN.y);
    float dist = distance(center,uv);
    
    color.rgb += ring(TIME,dist);
    
    
    COLOR.rgb = color;
//    float max_intensity_range = fract(TIME * 0.1);
//    float max_intensity_range = 0.2;
//    float dist = distance(uv,center); 
//    float val = max_intensity_range-uv;
    
}