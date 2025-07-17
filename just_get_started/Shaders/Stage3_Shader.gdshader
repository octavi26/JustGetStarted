shader_type canvas_item;
render_mode unshaded, blend_mix;

uniform float brightness : hint_range(-1.0, 1.0) = 0.0;
uniform float contrast : hint_range(0.0, 2.0) = 1.0;
uniform float desaturate : hint_range(0.0, 1.0) = 0.0;
uniform vec3 tint_color : source_color = vec3(0.1, 0.2, 0.4); // Night tint
uniform float tint_strength : hint_range(0.0, 1.0) = 0.5;
uniform float alpha : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    // Base overlay color (tint)
    vec3 col = tint_color;

    // Brightness and contrast adjustments to the tint itself
    col = ((col - 0.5) * contrast) + 0.5;
    col += brightness;

    // Desaturation (toward gray)
    float gray = dot(col.rgb, vec3(0.299, 0.587, 0.114));
    col = mix(col, vec3(gray), desaturate);

    // Final color output with transparency
    COLOR = vec4(col, alpha * tint_strength);
}
