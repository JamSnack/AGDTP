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

uniform sampler2D texColmap;

void main()
{
    vec4 spr;
    vec4 outp;
    spr=texture2D(gm_BaseTexture,v_vTexcoord);
    
    for (float i=0.0;i<=17.0;i++) { //we only have 18 colors (0-17)
        if (vec3(spr)==vec3(texture2D(texColmap,vec2(i/32.0,0.0)))) outp=vec4(i/32.0,i/32.0,i/32.0,spr.a); //32: The color map width
    }
    
    gl_FragColor=outp;
}
