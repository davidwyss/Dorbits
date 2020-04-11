shader_type canvas_item;


const float PI = 3.14159265358979323846;
uniform float ROTATIONAL_SPEED = 3.;
uniform float FRAMEBORDER = .025;
uniform float LOOPDELOOPS = 1.;
uniform float HP_PERCENT = .75;
uniform float ICON_DISTANCE = 1.2;
uniform vec4 HP_COLOR = vec4(.5,0.,.25,1.);
uniform int STATUS; //0-OK 1-ALERT 2-DESTROYED

uniform float ZOOM = 1.;
uniform vec4 WAVE_COLOR = vec4(1.);
uniform float WAVE_SPEED = 1.;
uniform float PULSE_RADIUS = 1;
uniform float EMISSION_SIZE = 1.;
uniform float ICON_WAVE_MIX = .95;

uniform vec2 SPAWN = vec2(.5);
uniform vec2 SPAWN_RANDOM = vec2(.0);

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
    float cosa = cos(rotation);
    float sina = sin(rotation);
    uv -= pivot;
    return vec2(
        cosa * uv.x - sina * uv.y,
        cosa * uv.y + sina * uv.x 
    ) + pivot;
}
vec4 createRing(vec2 uv,vec4 color){

    float x = (uv.x - 0.5) * 2.;
    float y = (uv.y - 0.5) * 2.;
    float d = sqrt(x * x + y * y);
    if(d > 1. - FRAMEBORDER && d < 1.) {
        float theta = atan(y, x) / PI;
        float b = (theta * 0.5) + 0.5;
        if(b < HP_PERCENT * 0.5 + 0.5){
            return HP_COLOR;
        }
    }
    return color;
}

vec4 pulsify(vec4 icon,vec2 uv,vec2 spawn,float time){
    if(icon.a !=0.){
        time = time * WAVE_SPEED;
        // Set the center point and thickness in pixels of the pulse effect
        vec2 p = uv -spawn;
        
        float r = length(p) / ZOOM;
        
        float a = pow(r, 2.0);
        float b = sin(r * PULSE_RADIUS - 1.6);
        float c = sin(r - 1.010) ;
        float s = sin(a - time+ b);
        
        vec3 color = WAVE_COLOR.rgb * abs(1.0 / (s / EMISSION_SIZE));
        return vec4(color*EMISSION_SIZE,1.);
    }
}


void fragment() {
    
    vec2 uv = UV;
    vec2 center = vec2(0.5);
    if(STATUS == 1){uv = rotateUV(uv,center,PI*sin(TIME*ROTATIONAL_SPEED/LOOPDELOOPS)*LOOPDELOOPS);}
    vec4 icon = texture(TEXTURE, uv*ICON_DISTANCE - (ICON_DISTANCE-1.)/2.);
    //create pulse
    vec2 spawnpoint= SPAWN + vec2(sin(TIME),cos(TIME))*SPAWN_RANDOM;
    icon = mix(pulsify(icon,uv,spawnpoint,TIME),icon,ICON_WAVE_MIX);
    //cutout
    COLOR.a = step(distance(center,uv),0.5);
    //create Rings
    COLOR = createRing(uv,icon);
}