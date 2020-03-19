shader_type canvas_item;


float random (vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898,78.243)))*43758.54531123);
}

void fragment() {
    vec2 st = UV;
    st *= 10.;
    vec2 ipos = floor(st);
    vec2 fpos = fract(st);
    COLOR = vec4(random( ipos * TIME * 0.0000001));
    COLOR.r = fpos.x * 0.125;
}
