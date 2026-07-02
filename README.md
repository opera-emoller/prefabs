# prefabs

gmx prefab catalog — 51 prefabs in the forward-looking unified `prefab.toml` format.

Each `prefabs/<id>/` directory contains a single `prefab.toml` with prefab-level
`id`, `version`, `kind`, `license`, optional `display_name`/`description`/`tags`,
an `[export]` table listing included resource paths, and one `[assets."<path>"]`
table per resource carrying that asset's `description`/`tags`. Per-asset metadata
that used to live in separate `descriptions.toml`/`tags.toml` sidecar files now
lives directly under `[assets]` in `prefab.toml`.
