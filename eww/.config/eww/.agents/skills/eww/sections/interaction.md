# Interaction rules

## button

Для простых кликов:

```yuck
(button
  :class "module"
  :onclick "pamixer -t"
  (label :text "VOL"))
```

Не полагайся на `~` в обработчиках. Используй абсолютный путь, `$HOME/...`, или скрипт-обёртку.

## eventbox

Для скролла, hover, drag/drop, богатых событий мыши:

```yuck
(eventbox
  :onscroll "$HOME/.config/eww/scripts/volume-change.sh {}"
  :onclick "pamixer -t"
  (label :text {volume_json?.text ?: "vol ?"}))
```

## scale

Для слайдеров:

```yuck
(scale
  :min 0
  :max 100
  :value {volume_json?.value ?: 0}
  :orientation "h"
  :onchange "pamixer --set-volume {}")
```

`onchange` может часто срабатывать при перетаскивании. Используй лёгкие команды.
