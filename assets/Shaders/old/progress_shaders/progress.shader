shader_type canvas_item;

uniform vec3 WAVE_COLOR = vec3(.9,2.2,2.5);
uniform float SPEED = 2.0;
uniform float LINE_WIDTH = .1;
uniform int LINES = 9;

void fragment()
{
    vec3 color = vec3(0.);
    vec2 uv  = -1.0 + 2.0 * UV;
    for(int i = 0; i < LINES; i++) {
        uv.y += (LINE_WIDTH * sin(uv.x + float(i/7) + TIME * SPEED ));
        float wave_width = abs(1.0 / (150.0 * uv.y));
    color += wave_width * WAVE_COLOR;
    }
    COLOR = vec4(color, 1.);
}