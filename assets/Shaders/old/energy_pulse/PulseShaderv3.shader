shader_type canvas_item;

uniform float EXPANSION_SPEED = 1.;
uniform float WAVE_SIZE = 3.;
uniform float WAVE_MAX_EXPANSION = 2.;
uniform vec4 WAVE_COLOR = vec4(1.);
uniform vec2 SPAWN = vec2(.5);
uniform vec2 SPAWN_RANDOM = vec2(.25);

float ring(float time,float dist)
{
    float start = sin(time *EXPANSION_SPEED)*WAVE_MAX_EXPANSION;
    return min(0.,.5 - abs(dist-start)*WAVE_SIZE);
}


void fragment() {
    COLOR = texture(TEXTURE,UV);
    vec2 uv = UV;
    if(COLOR != vec4(0.)){
        vec2 center = vec2(sin(TIME)*SPAWN_RANDOM.x + SPAWN.x,sin(TIME)*SPAWN_RANDOM.y+SPAWN.y);
        float dist = distance(center,uv);
        
        float intensity= ring(TIME,dist);
        
        
        COLOR += mix(COLOR,WAVE_COLOR,intensity);
    }
//    float max_intensity_range = fract(TIME * 0.1);
//    float max_intensity_range = 0.2;
//    float dist = distance(uv,center); 
//    float val = max_intensity_range-uv;
    
}