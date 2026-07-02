#version 300 es
precision highp float;

// Pinwheel room transition. Sweeps a rotating angular wedge that wipes
// from the outgoing room (from_tex) to the incoming room (to_tex).
//
// Adapted from gl-transitions' pinwheel.glsl by Mr Speaker (MIT).
// https://github.com/gl-transitions/gl-transitions/blob/master/transitions/pinwheel.glsl
// See LICENSE (Third-Party Components).

uniform sampler2D from_tex;   // outgoing room, bound to texture stage 0
uniform sampler2D to_tex;     // incoming room, bound to texture stage 1
uniform float progress;       // 0 -> 1 over the transition
uniform float speed;          // spin speed of the wedge

in vec2 v_vTexcoord;
out vec4 frag_colour;

// Surfaces are stored top-down, so flip v when sampling.
vec4 getToColor(vec2 uv) {
    return texture(to_tex, vec2(uv.x, 1.0 - uv.y));
}

vec4 getFromColor(vec2 uv) {
    return texture(from_tex, vec2(uv.x, 1.0 - uv.y));
}

vec4 transition(vec2 uv) {
    vec2 p = uv;

    float circPos = atan(p.y - 0.5, p.x - 0.5) + progress * speed;
    float modPos = mod(circPos, 3.1415 / 4.0);
    float signed = sign(progress - modPos);

    return mix(getToColor(p), getFromColor(p), step(signed, 0.5));
}

void main() {
    frag_colour = transition(v_vTexcoord);
}
