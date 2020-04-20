shader_type canvas_item;
uniform float ICON_DISTANCE = 1.;
uniform float BRIGHTNESS = 1.;
uniform float TIME_MOD = 1.;
uniform vec4 SPECIAL_COLOR = vec4(1.,1.,1.,1.); 

void fragment(){
    vec2 uv = UV;
    vec2 center = vec2(.5);
    float value = distance(center,uv);
//    vec4 icon = texture(TEXTURE, uv);
    vec4 icon = texture(TEXTURE, uv*ICON_DISTANCE - (ICON_DISTANCE-1.)/2.);
    COLOR = mix(icon,SPECIAL_COLOR*vec4(1.,1.,1.,icon.a),(BRIGHTNESS-value)*abs(sin(TIME*TIME_MOD)));    
}