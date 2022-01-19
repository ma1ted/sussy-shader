vec3 hueToRGB(in float H)
{
    float R = abs(H * 6. - 3.) - 1.;
    float G = 2. - abs(H * 6. - 2.);
    float B = 2. - abs(H * 6. - 4.);

    return clamp(vec3(0), vec3(1), vec3(R, G, B));
}

float triWave(in float t)
{
    float p = 2.;
    return 2. * abs((t/p) - floor((t/p)+.5));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord)
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    // Sussy texture
    vec4 sus = texture(iChannel1, uv);
    
    float sussySpeed = .8;
    float sussyShadow = 1.5;
    
    float sussyWave = triWave(iTime * sussySpeed);
    
    // Wave to hue
    vec4 sussyColourShift = vec4(hueToRGB(sussyWave).xyz, 1);
    
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
        o = sussyColourShift / sussyShadow;
    }
    else if (sus.x >= 254./255.)
    {
        // The main body (not in shadow)
        o = sussyColourShift;
    }
        

    // Output to screen
    fragColor = o;
}
