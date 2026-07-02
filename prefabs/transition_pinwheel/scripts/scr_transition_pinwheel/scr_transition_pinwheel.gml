/**
 * Transitions to another room with a pinwheel wipe effect.
 *
 * Captures the current room into a surface, switches to the target room,
 * captures that into a second surface, then composites the two through the
 * pinwheel shader over `time` seconds. If a transition is already running,
 * the call is ignored.
 *
 * Example:
 *   room_goto_transition_pinwheel(rm_level2, 1.5);        // default spin
 *   room_goto_transition_pinwheel(rm_level2, 1.5, 4.0);   // faster spin
 *
 * @param {Asset.GMRoom} room  The target room to transition to.
 * @param {Real} time          Duration of the transition in seconds.
 * @param {Real} [speed]       Optional spin speed of the pinwheel (default 2.0).
 */
function room_goto_transition_pinwheel(room, time, speed = 2.0) {
    if (!variable_global_exists("active_transition") || global.active_transition == -1) {
        global.active_transition = instance_create_depth(0, 0, 0, obj_transition_pinwheel);
        global.active_transition.target_room = room;
        global.active_transition.fade_length = time;
        global.active_transition.speed = speed;
    }
}

#export room_goto_transition_pinwheel
