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

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float Position;

void main()
{
    vec4 Colour = texture2D( gm_BaseTexture, v_vTexcoord ); // get colour of pixel
    float Max = max(Colour.r, max(Colour.g, Colour.b)); // get max channel of pixel
    float Min = min(Colour.r, min(Colour.g, Colour.b)); // get min channel of pixel
    float Sat = 1.0-Min/Max; // get current saturation of pixel
    // set saturation to pixel that depends on Position uniform
    Colour.r = clamp(Max-(Max-Colour.r)/Sat*(Sat+Position), 0.0, Max); // for red channel
    Colour.g = clamp(Max-(Max-Colour.g)/Sat*(Sat+Position), 0.0, Max); // for green channel
    Colour.b = clamp(Max-(Max-Colour.b)/Sat*(Sat+Position), 0.0, Max); // for blue channel
    gl_FragColor = v_vColour * Colour;
}
