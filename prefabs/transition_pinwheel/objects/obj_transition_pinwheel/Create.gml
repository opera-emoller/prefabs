// Pinwheel room transition driver. Created by room_goto_transition_pinwheel().
// Captures the outgoing room into from_surface, switches rooms, captures the
// incoming room into to_surface, then composites the two through shdr_pin_wheel.

var app = application_get_position();
screen_width = app[2] - app[0];
screen_height = app[3] - app[1];

from_surface = surface_create(screen_width, screen_height);
to_surface = surface_create(screen_width, screen_height);

t = 0.0;                 // elapsed time in seconds
target_room = -1;        // set by room_goto_transition_pinwheel()
fade_length = 2.0;       // total duration in seconds (overridden by caller)
speed = 2.0;             // pinwheel spin speed (overridden by caller)
in_target = false;       // false until the outgoing room has been captured

// Cache shader uniform handles.
u_progress = shader_get_uniform(shdr_pin_wheel, "progress");
u_speed = shader_get_uniform(shdr_pin_wheel, "speed");
u_from = shader_get_uniform(shdr_pin_wheel, "from_tex");
u_to = shader_get_uniform(shdr_pin_wheel, "to_tex");
