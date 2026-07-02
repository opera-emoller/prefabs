# Transition Base

Room-to-room transitions for gmx / GameMaker. Captures the outgoing room to a
surface, switches rooms, captures the incoming room to a second surface, then
blends the two with a full-screen fragment shader over a set duration.

This is the **base**: it ships the machinery (`obj_transition`), the API
(`goto`), and a plain **fade** as the default effect (`sh_transition`). Derived
transitions inherit all of that via `[parent-link]` and override only
`shaders/sh_transition/fragment.fsh`.

## Usage

Once added to a project it is namespaced under the prefab folder, e.g.:

```gml
::transition_fade::goto(rm_next);             // 1s, default fade
::transition_fade::goto(rm_next, 1.5);        // 1.5s
::transition_fade::goto(rm_next, 1.5, { speed_f: 2.0 });  // + shader uniforms
```

`goto(room, [time], [params])` — `params` sets extra fragment-shader uniforms
by suffix: `_f` float, `_i` int, `_b` bool, `_vec2`/`_vec3`/`_vec4` float
arrays.

## Attribution & license

© Opera Software — MIT (see `LICENSE`).
