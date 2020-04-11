shader_type canvas_item;

uniform float EXPANSION_SPEED = 1.;
uniform float WAVE_SIZE = 3.;
uniform float WAVE_MAX_EXPANSION = 2.;
uniform vec3 WAVE_COLOR = vec3(1.);
uniform float FUN_VARIABLE = 64.;
uniform vec2 SPAWN = vec2(.5);
uniform vec2 SPAWN_RANDOM = vec2(.25);


void fragment() {
    vec2 uv = UV;
    vec3 color = WAVE_COLOR;
    vec2 center = vec2(sin(TIME)*SPAWN_RANDOM.x + SPAWN.x,sin(TIME)*SPAWN_RANDOM.y+SPAWN.y);
    float dist = distance(center,uv);
    float time = TIME*EXPANSION_SPEED;
    time += step(1., mod(dist*FUN_VARIABLE,1.5)) / FUN_VARIABLE;
    float start = fract(time)*WAVE_MAX_EXPANSION;
    
    color.rgb -= abs(dist-start)*WAVE_SIZE;

    COLOR.rgb = color;
//    float max_intensity_range = fract(TIME * 0.1);
//    float max_intensity_range = 0.2;
//    float dist = distance(uv,center); 
//    float val = max_intensity_range-uv;
    
}