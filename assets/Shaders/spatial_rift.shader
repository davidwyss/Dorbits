shader_type spatial;

vec2 brickTile(vec2 st, float zoom){
    st *= zoom;
    // Here is where the offset is happening
    st.x += step(1., mod(st.y,2.0)) * 0.5;
    return fract(st);
}

vec3 get_color(float time,vec2 uv,vec2 st){
    return vec3(sin(uv.y*uv.x),0.,0.);
}

vec3 box(vec2 st, vec2 size, vec3 color){
    size = vec2(0.2);
    vec2 uv = smoothstep(size,size+vec2(0.0001),st);
    uv *= smoothstep(size,size+vec2(0.0001),vec2(1.0)-st);
    return uv.y*uv.x*color;
}

void vertex(){
    VERTEX.rg *=  UV;    
}

void fragment(){
    vec2 st = UV;
    st.y *= 3.141*0.05;
    vec3 color = vec3(0.0);
    st = brickTile(st,256.);
    color = box(st*vec2(1.2,1.1),vec2(1.),vec3(0.,1.,1.));
    ALBEDO = color;
}
