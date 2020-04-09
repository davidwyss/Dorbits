shader_type canvas_item;

//uniform sampler2D noise;
uniform float SPEED = 0.2;
uniform float SHINYNESS = 0.2;
uniform float PERCENTAGE = 0.2;
uniform vec3 LIGHTNING_COLOR = vec3(1.70, 1.48, 1.78);

float plot(vec2 st, float pct, float smoothing){
  return  smoothstep( pct-smoothing, pct, st.y) -
          smoothstep( pct, pct+smoothing, st.y);
}

void fragment(){
    
  vec2 uv = UV;    
  uv = uv * 2. -1.;  
  uv.y*= 0.5;
    
  float intensity = sin(TIME*SPEED);
                          
  float t = clamp((uv.x * -uv.x * 0.16) + 0.15, 0., 1.);                         
  float y = abs(intensity * -t + uv.y);
    
  float g = pow(y, SHINYNESS);
                          
  vec3 col = LIGHTNING_COLOR;
  
  float multiplier = 0.25+PERCENTAGE-UV.x;
  if(PERCENTAGE>0.99){ multiplier = 1.;  }         
  col = col*(col * -g + col)*multiplier;
  COLOR.rgb = col;                          
  COLOR.w = 1.;  
}