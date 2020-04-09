shader_type canvas_item;

uniform vec3 WAVE_COLOR = vec3(1.);
uniform vec3 WAVE_COLOR2 = vec3(1.);
uniform float SPEED = 2.0;
uniform float LINE_WIDTH = .1;
uniform int LINES = 9;

vec3 lines(vec3 wave_color,vec2 uv,float time){
    vec3 color = vec3(0.);
    for(int i = 0; i < LINES; i++) {
        uv.y += LINE_WIDTH * sin(uv.x + float(i/7) +  time * SPEED);
        float wave_width = abs(1.0 / (150.0 * uv.y));
        color += wave_width * wave_color;
    }
    return color;  
}

void fragment()
{
    float c = 10.;
    vec2 uv   = abs(1. - 2.0 * UV);
    uv*=2.;
    COLOR = vec4(lines(WAVE_COLOR*c,uv ,TIME) + lines(WAVE_COLOR2*c,-uv + 1.,-TIME) -c*.1 , 1.);
}