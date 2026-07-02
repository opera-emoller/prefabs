// Demo driver. Each demo room runs one of these. SPACE pinwheels to the other
// room. The two rooms use contrasting colours so the transition is easy to see.
if (room == rm_demo) {
    bg = make_colour_rgb(28, 28, 60);
    accent = make_colour_rgb(120, 180, 255);
    target = rm_demo_b;
} else {
    bg = make_colour_rgb(60, 22, 32);
    accent = make_colour_rgb(255, 160, 110);
    target = rm_demo;
}
