shader_type canvas_item;
render_mode unshaded;

uniform sampler2D TEX;
uniform bool CORRUPT_IT = false;
uniform float CORRUPT_IT_BRIGHTNESS = 1.;
uniform float BG_MOVE_SPEED = 1.;
uniform float EDGE_DISTANCE = 1.;
uniform float ROTATION_RANGE = .1;

void fragment(){
//    vec2 uv = SCREEN_UV +EDGE_DISTANCE+ EDGE_DISTANCE *vec2(cos(TIME*BG_MOVE_SPEED),sin(TIME*BG_MOVE_SPEED));
    vec2 uv = SCREEN_UV * EDGE_DISTANCE - (EDGE_DISTANCE-1.)/2.;
//    vec2 uv = SCREEN_UV *EDGE_DISTANCE + vec2(0.25);
    uv += vec2(cos(TIME*BG_MOVE_SPEED),sin(TIME*BG_MOVE_SPEED))*ROTATION_RANGE;
    vec4 o = textureLod(SCREEN_TEXTURE,SCREEN_UV,0.).rgba;
    vec4 c = texture(TEX,uv).rgba;
    if(CORRUPT_IT){
        c.rgb =  (1.2 - c.rgb)*CORRUPT_IT_BRIGHTNESS;  
     }
    COLOR = c*o;    
}