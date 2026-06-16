# Wayland vs X11 rules

У Eww разное поведение окон на Wayland и X11. Не мешай вслепую.

---

## Wayland bar

Используй `:exclusive true` для резервирования места на layer-shell Wayland:

```yuck
(defwindow mainbar
  :monitor 0
  :geometry (geometry
    :x "0%"
    :y "0%"
    :width "100%"
    :height "32px"
    :anchor "top center")
  :stacking "fg"
  :exclusive true
  :focusable false
  :namespace "eww-mainbar"
  (bar))
```

Wayland-опции:
```yuck
:stacking "fg" | "bg" | "overlay" | "bottom"
:exclusive true | false
:focusable true | false
:namespace "name"
```

`:exclusive true` — для баров, `:exclusive false` — для оверлеев/попапов.

---

## Wayland popup

На Wayland топ-левел окно Eww перехватывает ввод, даже если контент спрятан. Не держи постоянный попап и не прячь его содержимое `revealer`/`:visible` — клики не пройдут сквозь окно.

Надёжный попап:

```yuck
(defwindow calendar-popup-window
  :monitor 0
  :geometry (geometry
    :x "64px"
    :y "24px"
    :width "280px"
    :height "260px"
    :anchor "bottom right")
  :stacking "overlay"
  :exclusive false
  :focusable false
  :namespace "eww-calendar-popup"
  (calendar-popup))
```

Переключай само окно:

```sh
eww open --toggle calendar-popup-window
```

Правила попапов:
- отдельный `defwindow` для каждого попапа;
- закрывай скрытые окна через `eww close` или `eww open --toggle`;
- не полагайся на `revealer` для click-through;
- позиционируй попап так, чтобы он не накрывал триггер;
- лучше без анимации закрытия, чем race-prone `update + sleep + close`;
- `:exclusive false`, `:focusable false` если не нужно резервировать место или фокус.

---

## X11 bar

На X11 используй `:reserve (struts ...)` вместо Wayland `:exclusive`:

```yuck
(defwindow mainbar
  :monitor 0
  :geometry (geometry
    :x "0%"
    :y "0%"
    :width "100%"
    :height "32px"
    :anchor "top center")
  :stacking "fg"
  :windowtype "dock"
  :reserve (struts :distance "32px" :side "top")
  (bar))
```

X11-опции:
```yuck
:windowtype "dock"
:reserve (struts :distance "..." :side "top" | "bottom" | "left" | "right")
```

Не используй `:windowtype` на Wayland.

---

## River-specific

Не генерируй Hyprland/Sway-команды для River без явной просьбы.

Избегай хардкода:
```yuck
(button :onclick "hyprctl dispatch workspace 1" ...)
```

Делай скрипты-обёртки:

```yuck
(button
  :onclick "$HOME/.config/eww/scripts/workspace-switch.sh 1"
  (label :text "1"))
```

```sh
#!/usr/bin/env sh
set -eu
workspace="${1:?workspace required}"
if command -v riverctl >/dev/null 2>&1; then
  riverctl set-focused-tags "$workspace"
elif command -v swaymsg >/dev/null 2>&1; then
  swaymsg workspace "$workspace"
elif command -v hyprctl >/dev/null 2>&1; then
  hyprctl dispatch workspace "$workspace"
fi
```

Для River тегов/workspaces предпочитай фильтрацию пустых/скрытых на стороне скрипта, а не CSS.
