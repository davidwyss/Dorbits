shader_type canvas_item;

void fragment(){ 
    vec2 uv = vec2(abs(0.5 - UV.y), COLOR.a);//create uv
    COLOR.r -= .95*uv.y;
    COLOR.g -= .95*uv.x;
}