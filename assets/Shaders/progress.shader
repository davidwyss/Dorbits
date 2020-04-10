shader_type canvas_item;


const float PI = 3.14159265358979323846;
uniform float SPEED = 3.14159265358979323846;
uniform float FRAMEBORDER = .14159265358979323846;
uniform float LOOPDELOOPS = 1.;
uniform float HP_PERCENT = 1.;
uniform float STATUS_COLOR_MIX = 0.2;
uniform vec3 STATUS_ALERT_COLOR = vec3(0.,0.,1.);
uniform vec3 STATUS_DISABLED_COLOR = vec3(1.,1.,0.);
uniform vec3 STATUS_DESTROYED_COLOR = vec3(1.,0.,0.);
uniform vec3 HP_COLOR = vec3(1.,0.,0.);

uniform int STATUS; //0-OK 1-ALERT 2-DISABLED 3-DESTROYED

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
    vec3 status_color;
    if(STATUS == 1){
        status_color = vec3(STATUS_ALERT_COLOR);
        uv = rotateUV(uv,center,PI*sin(TIME*SPEED)*LOOPDELOOPS);
    }else if(STATUS == 2){status_color = vec3(STATUS_DISABLED_COLOR);}
    else if(STATUS == 3){status_color = vec3(STATUS_DESTROYED_COLOR);}
    vec3 color = mix(texture(TEXTURE, uv).rgb,status_color,STATUS_COLOR_MIX);
    
    //cutout
    COLOR.a = step(distance(center,uv),0.5);
    
    //ring
    float x = (uv.x - 0.5) * 2.;
    float y = (uv.y - 0.5) * 2.;
    float d = sqrt(x * x + y * y);
    if(d > 1. - FRAMEBORDER && d < 1.) {
        float theta = atan(y, x) / PI;
        float b = (theta * 0.5) + 0.5;
        if(b < HP_PERCENT * 0.5 + 0.5)
            color.rgb = vec3(HP_COLOR);
    }
    COLOR.rgb = color;
}