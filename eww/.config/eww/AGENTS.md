# Eww Config

Write less, do exact.

## Scope

- This directory is a local Eww config for a River/Wayland vertical bar.
- Eww version target: `0.6.0`.
- Main entrypoints:
  - `eww.yuck`
  - `eww.scss`
- The real bar implementation lives under `bar/`.
- Helper scripts are part of modules and live next to the module that uses them.

## Structure

```text
eww.yuck                 # one include: bar/index.yuck
eww.scss                 # one import: bar/index.scss
bar/index.yuck           # imports module index + bar window/layout
bar/index.scss           # imports tokens + base + bar + module styles
bar/tokens.scss          # design tokens only
bar/base.scss            # global reset and shared module styles
bar/bar.yuck             # bar layout/window only
bar/bar.scss             # bar container styles only
bar/modules/<name>/      # one module per folder
bar/modules/<name>/index.yuck
bar/modules/<name>/index.scss
bar/modules/<name>/<name>.yuck
bar/modules/<name>/<name>.scss
bar/modules/<name>/<helper-script>
```

## Module Rules

- New bar module goes in `bar/modules/<name>/`.
- Each module must have `index.yuck` and `index.scss`.
- Import the module from:
  - `bar/modules/index.yuck`
  - `bar/modules/index.scss`
- Keep widget names stable and simple: `clock`, `volume`, `tag-list`, `calendar-popup`.
- Put module-specific scripts in that module folder, not in the config root.
- Use absolute paths in Eww event handlers. Do not use `~` in `:onclick`, `:onscroll`, or scripts.

## SCSS Rules

- Raw colors belong only in `bar/tokens.scss`.
- Module SCSS must use semantic tokens, not hex/rgba literals.
- Import order in `bar/index.scss` must be:
  1. `tokens.scss`
  2. `base.scss`
  3. `bar.scss`
  4. `modules/index.scss`
- Prefer semantic tokens such as:
  - `$module-bg`
  - `$module-bg-hover`
  - `$fg-primary`
  - `$fg-muted`
  - `$popup-bg`
  - `$tag-focused-bg`
  - `$state-critical-bg`
- If a new color is needed, add it first to `bar/tokens.scss`, preferably derived from the `wlogout` palette.
- Current palette source: `~/.config/wlogout/style.css`.
- Do not introduce browser-only CSS assumptions. Eww uses GTK CSS.

## Yuck Rules

- Keep `eww.yuck` as a single include unless there is a strong reason.
- Keep `bar/bar.yuck` focused on layout/windows, not module internals.
- Keep module state definitions (`defpoll`, `deflisten`, `defvar`) inside the module that owns them.
- Include order matters. If module A uses vars/widgets from module B, include B first.
- Do not use generated `literal` widgets unless there is no simpler Eww widget approach.

## River Rules

- This config is River-specific.
- Do not add Hyprland/Sway commands.
- River tags are driven by `ristate` and `riverctl` helper scripts.
- Hide empty inactive tags at the data source, not with CSS.
- Keep tag switching through helper scripts, not inline compositor commands.

## Popup Rules

- For Wayland popups, prefer separate temporary `defwindow`s.
- Hidden popup windows must be closed with `eww close`; do not keep invisible windows open.
- Do not use a persistent hidden window with `revealer` or `:visible` as the window hiding mechanism.
- Eww 0.6.0 has no reliable click-through/input-passthrough for hidden Wayland windows.
- For reliable popups, prefer `eww open --toggle <window>` over custom state parsing.
- Popup windows should be `:exclusive false` and `:focusable false` unless keyboard focus is explicitly needed.
- Position popups so they do not cover the widget that toggles them.
- Close animation is optional; reliability is more important.

## Script Rules

- Scripts should use:

```sh
#!/usr/bin/env sh
set -eu
```

- Make scripts executable after creating or moving them:

```sh
chmod +x ~/.config/eww/bar/modules/<name>/<script>
```

- Prefer explicit config when calling Eww from scripts:

```sh
eww --config "$HOME/.config/eww" open --toggle window-name
```

- If PATH is unreliable from Eww handlers, use the full Eww path from `command -v eww` observed in the session.
- Scripts should output compact text or valid JSON.
- Validate JSON-producing scripts directly before blaming Eww.

## Current Helper Scripts

- `bar/modules/tags/river-eww-tags`
- `bar/modules/volume/eww-volume-state`
- `bar/modules/power-profile/eww-power-profile-state`
- `bar/modules/calendar/toggle-calendar`
- `bar/modules/calendar/close-calendar`

## Validation

After edits, run:

```sh
eww reload
```

For popup/window bugs, check:

```sh
eww active-windows
eww close calendar-popup-window
eww open --toggle calendar-popup-window
```

For event-handler debugging, temporarily use:

```yuck
:onclick "notify-send eww-click"
```

For scripts:

```sh
sh -n path/to/script
path/to/script
```

## Do Not

- Do not rewrite the whole config for small widget changes.
- Do not move module internals back into top-level `eww.yuck` or `eww.scss`.
- Do not add hidden aggregators outside the explicit `index.*` files.
- Do not use `sudo`.
- Do not keep a hidden Wayland popup window open if it can intercept clicks.
- Do not add raw colors outside `bar/tokens.scss`.
- Do not use `~` in Eww event-handler command paths.
