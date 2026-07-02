#version 300 es
precision highp float;

// sh_transition — default effect: fade.
// Adapted from gl-transitions `fade.glsl` (MIT):
//   https://github.com/gl-transitions/gl-transitions/blob/master/transitions/fade.glsl
//
// Contract for every derived transition shader: sample the outgoing room from
// `from_tex` and the incoming room from `to_tex` via getFromColor/getToColor,
// then blend by `progress` (0..1). getFromColor/getToColor flip V to match the
// surface-texture orientation (keep the flip; it renders upright in-game).
// Extra effect uniforms (if any) are set from goto()'s `params`.

uniform sampler2D from_tex;
uniform sampler2D to_tex;
uniform float progress;

in vec2 v_vTexcoord;
out vec4 frag_colour;

vec4 getToColor(vec2 uv)   { return texture(to_tex,   vec2(uv.x, 1.0 - uv.y)); }
vec4 getFromColor(vec2 uv) { return texture(from_tex, vec2(uv.x, 1.0 - uv.y)); }

vec4 transition(vec2 uv) {
    return mix(getFromColor(uv), getToColor(uv), progress);
}

void main() {
    frag_colour = transition(v_vTexcoord);
}
