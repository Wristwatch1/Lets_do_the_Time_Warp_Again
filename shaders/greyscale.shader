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

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    
    vec4 basecolor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    vec3 filtercolor = vec3(
    basecolor.r * 0.2126,
    basecolor.g * 0.7152,
    basecolor.b * 0.0722
    );
    float luminance = dot(vec3(basecolor.rgb),filtercolor);
    
    
    gl_FragColor = vec4(luminance,luminance,luminance + 0.3,basecolor.a);
}

