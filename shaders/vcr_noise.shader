//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;


void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~uniform vec3      iResolution;           // viewport resolution (in pixels)
uniform float     iGlobalTime;           // shader playback time (in seconds)
//uniform float     iTimeDelta;            // render time (in seconds)
//uniform int       iFrame;                // shader playback frame
//uniform float     iChannelTime[4];       // channel playback time (in seconds)
//uniform vec3      iChannelResolution[4]; // channel resolution (in pixels)
//uniform vec4      iMouse;                // mouse pixel coords. xy: current (if MLB down), zw: click
//uniform samplerXX iChannel0..3;          // input channel. XX = 2D/Cube
//uniform vec4      iDate;                 // (year, month, day, time in seconds)
//uniform float     iSampleRate;           // sound sample rate (i.e., 44100)


//by Vladimir Storm 
//https://twitter.com/vladstorm_

#define t iGlobalTime

varying vec2 v_vTexcoord;
varying vec4 v_vColour;


//random hash
vec4 hash42(vec2 p)
{
    vec4 p4 = fract(vec4(p.xyxy) * vec4(443.8975,397.2973, 491.1871, 470.7827));
    p4 += dot(p4.wzxy, p4+19.19);
    return fract(vec4(p4.x * p4.y, p4.x*p4.z, p4.y*p4.w, p4.x*p4.w));
}


float hash( float n )
{
    return fract(sin(n)*43758.5453123);
}

// 3d noise function (iq's)
float n( in vec3 x )
{
    vec3 p = floor(x);
    vec3 f = fract(x);
    f = f*f*(3.0-2.0*f);
    float n = p.x + p.y*57.0 + 113.0*p.z;
    float res = mix(mix(mix( hash(n+  0.0), hash(n+  1.0),f.x),
                        mix( hash(n+ 57.0), hash(n+ 58.0),f.x),f.y),
                    mix(mix( hash(n+113.0), hash(n+114.0),f.x),
                        mix( hash(n+170.0), hash(n+171.0),f.x),f.y),f.z);
    return res;
}


//tape noise
float nn(vec2 p)
{
    float y = p.y;
    float s = t*2.;
    
    float v = (n( vec3(y*.01 +s, 1., 1.0) ) + .0)
        *(n( vec3(y*.011+1000.0+s, 1., 1.0) ) + .0) 
        *(n( vec3(y*.51+421.0+s, 1., 1.0) ) + .0)   
    ;
    //v*= n( vec3( (fragCoord.xy + vec2(s,0.))*100.,1.0) );
    v*= hash42(   vec2(p.x +t*0.01, p.y) ).x +.3 ;

    
    v = pow(v+.3, 1.);
    if(v<.7) v = 0.;  //threshold
    return v;
}

void main()
{

    vec2 uv = v_vTexcoord.xy / v_vTexcoord.xy;
    
    
    float linesN = 240.; //fields per seconds
    float one_y = iResolution.y / linesN; //field line
    uv = floor(uv*iResolution.xy/one_y)*one_y;
    
    float col =  nn(uv);
        
        
        
    gl_FragColor = vec4(vec3( col ),1.0);
}
/*//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
*/
