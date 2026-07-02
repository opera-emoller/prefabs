/// @function goto(room, [time], [params])
/// @description Transition to `room` over `time` seconds using this prefab's
/// fragment shader (sh_transition). `params` sets extra shader uniforms by
/// suffix: _f float, _i int, _b bool, _vec2/_vec3/_vec4 float arrays —
/// e.g. goto(rm_next, 1.0, { speed_f: 2.0 }).
function goto(room, time = 1.0, params = {}) {
    if (!variable_global_exists("active_transition") || global.active_transition == -1) {
        global.active_transition = instance_create_depth(0, 0, 0, obj_transition);
        global.active_transition.target_room = room;
        global.active_transition.fade_length = time;
        global.active_transition.configure(params);
    }
}
