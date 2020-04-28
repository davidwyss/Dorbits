shader_type canvas_item;


const float PI = 3.14159265358979323846;
uniform float ROTATIONAL_SPEED = 3.;
uniform float FRAMEBORDER = .025;
uniform float LOOPDELOOPS = 1.;
uniform float HP_PERCENT = .75;
uniform float ICON_DISTANCE = 1.1;
uniform int STATUS; //0-OK 1-ALERT 2-DESTROYED

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
    float cosa = cos(rotation);
    float sina = sin(rotation);
    uv -= pivot;
    return vec2(
        cosa * uv.x - sina * uv.y,
        cosa * uv.y + sina * uv.x 
    ) + pivot;
}

void fragment() {
    
    vec2 uv = UV;
    vec2 center = vec2(0.5);
    if(STATUS == 1){uv = rotateUV(uv,center,PI*sin(TIME*ROTATIONAL_SPEED/LOOPDELOOPS)*LOOPDELOOPS);}
    vec4 icon = texture(TEXTURE, uv*ICON_DISTANCE - (ICON_DISTANCE-1.)/2.);
    //cutout
    COLOR.a = step(distance(center,uv),0.5);
    //create Rings
    COLOR = icon;
}