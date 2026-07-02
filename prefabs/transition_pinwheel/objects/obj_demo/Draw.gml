// Fill the room and draw a radial pattern, so the pinwheel wipe is clearly
// visible as it sweeps between the two rooms.
draw_clear(bg);

var cx = room_width / 2;
var cy = room_height / 2;
var maxr = point_distance(0, 0, cx, cy);

draw_set_colour(accent);

// Radial spokes.
var spokes = 24;
for (var i = 0; i < spokes; i++) {
    var a = i / spokes * 360;
    draw_line_width(cx, cy, cx + lengthdir_x(maxr, a), cy + lengthdir_y(maxr, a), 2);
}

// Concentric rings.
for (var r = 70; r < maxr; r += 80) {
    draw_circle(cx, cy, r, true);
}

// Centre disc.
draw_circle_colour(cx, cy, 60, accent, bg, false);

draw_set_colour(c_white);
