void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    // Sussy texture
    vec4 sus = texture(iChannel1, uv);
    
    float sussySpeed = 9.;
    float sussyShadow = 1.5;
    
    float sussyWave = sin(iTime * sussySpeed) * .15 + .85;
    
    vec4 sussyColour = vec4(uv.y, uv.x, sussyWave, 1);
    
    // Output colour
    vec4 o;
    
    if (sus.z > 200./255.)
    {
        // Preserve the sussy visor. It is the only region with a high blue channel value which makes things simpler.
        o = sus;
    }
    else if (sus.x < 248./255.)
    {
        // The background (& outline)
        o = vec4(54./255., 57./255., 63./255., 1);
    }
    else if (sus.x >= 248./255. && sus.x < 254./255.)
    {
        // The part of the body in shadow.
        o = sussyColour / sussyShadow;
    }
    else if (sus.x >= 254./255.)
    {
        // The main body (not in shadow)
        o = sussyColour;
    }
        
    // Output to screen
    fragColor = o;
}
