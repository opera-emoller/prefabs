#version 300 es
precision highp float;

// sh_transition — effect: flye-eye.
// Adapted from gl-transitions `flyeye.glsl` (MIT):
//   https://github.com/gl-transitions/gl-transitions/blob/master/transitions/flyeye.glsl
// Overrides transition-base's fragment shader; the vertex shader is inherited.
// Keep the V-flip in getFromColor/getToColor (matches the base contract).

uniform sampler2D from_tex;
uniform sampler2D to_tex;
uniform float progress;

in vec2 v_vTexcoord;
out vec4 frag_colour;

vec4 getToColor(vec2 uv)   { return texture(to_tex,   vec2(uv.x, 1.0 - uv.y)); }
vec4 getFromColor(vec2 uv) { return texture(from_tex, vec2(uv.x, 1.0 - uv.y)); }

uniform float size;              // set via goto(..., { size_f: N });             0 => 0.04
uniform float zoom;              // set via goto(..., { zoom_f: N });             0 => 50.0
uniform float color_separation;  // set via goto(..., { color_separation_f: N }); 0 => 0.3

vec4 transition(vec2 p) {
  float sz   = (size == 0.0)             ? 0.04 : size;
  float zm   = (zoom == 0.0)             ? 50.0 : zoom;
  float csep = (color_separation == 0.0) ? 0.3  : color_separation;
  float inv = 1. - progress;
  vec2 disp = sz*vec2(cos(zm*p.x), sin(zm*p.y));
  vec4 texTo = getToColor(p + inv*disp);
  vec4 texFrom = vec4(
    getFromColor(p + progress*disp*(1.0 - csep)).r,
    getFromColor(p + progress*disp).g,
    getFromColor(p + progress*disp*(1.0 + csep)).b,
    1.0);
  return texTo*progress + texFrom*inv;
}

void main() {
    frag_colour = transition(v_vTexcoord);
}
