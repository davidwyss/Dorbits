shader_type canvas_item;

uniform sampler2D noise;
uniform float speed = 0.2;
uniform vec3 line_color = vec3(0.5,0.1,0.9);
uniform vec3 line_color2 = vec3(0.8,1.8,0.1);

float plot(vec2 st, float pct, float smoothing){
  return  smoothstep( pct-smoothing, pct, st.y) -
          smoothstep( pct, pct+smoothing, st.y);
}

void fragment(){
    vec2 st = UV;
    st.x -= TIME * speed;
    COLOR.rgb = vec3(0.,0.,0.);
    vec4 n = texture(noise, st);
    float pct = plot(st,n.y,0.4);
    float pct1 = plot(st,n.y,0.1);
    COLOR.rgb = mix(pct*line_color,pct1 * line_color2,0.5)*2.;
}