// Size the capture surfaces to the backing buffer (the application surface),
// NOT application_get_position() — that returns the window/canvas rect and
// mis-sizes the surfaces on the wasm target.
var w = surface_get_width(application_surface);
var h = surface_get_height(application_surface);
from_surface = surface_create(w, h);
to_surface   = surface_create(w, h);

t = 0.0;
target_room = -1;
fade_length = 1.0;
in_target = false;

u_progress = shader_get_uniform(sh_transition, "progress");
uniforms = [];   // each entry: [tag, loc, values]  tag 0 = int, 1 = float, 2 = float array

// Build the extra-uniform list from a params struct, by name suffix.
configure = function(p) {
    uniforms = [];
    var keys = variable_struct_get_names(p);
    for (var i = 0; i < array_length(keys); i++) {
        var key = keys[i];
        var val = p[$ key];
        if (string_ends_with(key, "_b")) {
            var loc = shader_get_uniform(sh_transition, string_delete(key, string_length(key) - 1, 2));
            array_push(uniforms, [0, loc, [val ? 1 : 0]]);
        } else if (string_ends_with(key, "_i")) {
            var loc = shader_get_uniform(sh_transition, string_delete(key, string_length(key) - 1, 2));
            array_push(uniforms, [0, loc, [val]]);
        } else if (string_ends_with(key, "_f")) {
            var loc = shader_get_uniform(sh_transition, string_delete(key, string_length(key) - 1, 2));
            array_push(uniforms, [1, loc, [val]]);
        } else if (string_ends_with(key, "_vec2") || string_ends_with(key, "_vec3") || string_ends_with(key, "_vec4")) {
            var loc = shader_get_uniform(sh_transition, string_delete(key, string_length(key) - 4, 5));
            array_push(uniforms, [2, loc, val]);
        }
    }
    // Fixed uniforms: the two source textures (stages 0/1) + aspect ratio.
    array_push(uniforms, [0, shader_get_uniform(sh_transition, "from_tex"), [0]]);
    array_push(uniforms, [0, shader_get_uniform(sh_transition, "to_tex"), [1]]);
    array_push(uniforms, [1, shader_get_uniform(sh_transition, "ratio"), [display_get_width() / display_get_height()]]);
};

configure({});
