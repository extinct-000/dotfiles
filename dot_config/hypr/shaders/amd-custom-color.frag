// amd-custom-color.frag
// Approximates AMD Adrenalin Custom Color:
// Saturation 112, Contrast 99, Brightness 1, Hue 1
#version 300 es
precision highp float;

in vec2 v_texcoord;
uniform sampler2D tex;
layout(location = 0) out vec4 fragColor;

// === Tunable parameters (match AMD values) ===
const float SATURATION = 1.60;   // 112 / 100
const float CONTRAST   = 0.99;   // 99 / 100
const float BRIGHTNESS = 1.01;   // very slight lift for "1"
const float HUE_DEG    = 1.0;    // +1 degree

// Helper: RGB <-> HSV
vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0/3.0, 2.0/3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0/3.0, 1.0/3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main() {
    vec4 pix = texture(tex, v_texcoord);
    vec3 color = pix.rgb;

    // 1. Brightness
    color *= BRIGHTNESS;

    // 2. Contrast (around mid-gray)
    color = (color - 0.5) * CONTRAST + 0.5;

    // 3. Hue + Saturation via HSV
    vec3 hsv = rgb2hsv(color);
    hsv.x = fract(hsv.x + HUE_DEG / 360.0);   // hue shift
    hsv.y *= SATURATION;                      // saturation
    color = hsv2rgb(hsv);

    // Clamp and output
    fragColor = vec4(clamp(color, 0.0, 1.0), pix.a);
}
