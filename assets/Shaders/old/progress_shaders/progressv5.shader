shader_type canvas_item;

uniform vec3 WAVE_COLOR = vec3(.9,2.2,2.5);
uniform float SPEED = 2.0;
uniform float LINE_WIDTH = .1;
uniform int LINES = 9;

vec3 lines(vec2 uv,float time){
    vec3 color = vec3(0.);
    for(int i = 0; i < LINES; i++) {
        uv.y += LINE_WIDTH * sin(uv.x + float(i/7) + time * SPEED);
        float wave_width = abs(1.0 / (150.0 * uv.y));
        color += wave_width * WAVE_COLOR;
    }
    return color;  
}

void fragment()
{
    vec2 uv  = 1. - 2.0 * UV;
    uv*=2.;
    COLOR = vec4(lines(uv*uv,TIME), 1.)*vec4(lines(-uv*uv,TIME), 1.);
}