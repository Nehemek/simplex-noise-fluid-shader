#pragma language glsl3

//-----------------------------------------------------------------------------
// FRAGMENT
//-----------------------------------------------------------------------------

#ifdef PIXEL

vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
    {
        vec2 pixelsize = 1.0/vec2(textureSize(tex,0));
        
        vec4 pixelC = Texel(tex, VaryingTexCoord.xy);
        vec4 pixelL = Texel(tex, VaryingTexCoord.xy + vec2(-1, 0) * pixelsize);
        vec4 pixelT = Texel(tex, VaryingTexCoord.xy + vec2(0, -1) * pixelsize);
        vec4 pixelR = Texel(tex, VaryingTexCoord.xy + vec2( 1, 0) * pixelsize);
        vec4 pixelB = Texel(tex, VaryingTexCoord.xy + vec2(0,  1) * pixelsize);

        pixelC.rgb += (
              pixelL.rgb * 1.35
            + pixelR.rgb * 0.65
            + pixelT.rgb * 0
            + pixelB.rgb * 2
            - 4 * pixelC.rgb
            )
        * 10.0 * 0.016;

        pixelC -= 0.001;

        return pixelC;
    }

#endif