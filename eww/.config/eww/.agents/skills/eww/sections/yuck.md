# Yuck style rules

Предпочитай маленькие композируемые виджеты.

Хорошо:
```yuck
(defwidget bar []
  (centerbox :orientation "h"
    (bar-left)
    (bar-center)
    (bar-right)))

(defwidget bar-left []
  (box :class "bar-left" :orientation "h" :spacing 8
    (workspaces)))

(defwidget bar-center []
  (box :class "bar-center"
    (clock)))

(defwidget bar-right []
  (box :class "bar-right" :orientation "h" :spacing 8
    (volume)
    (battery)))
```

Избегай одного гигантского `defwidget`.

Имена: `mainbar`, `bar`, `bar-left`, `clock`, `battery`, `volume`, `workspaces`, `powermenu`.

---

## Expressions and JSON access

Eww выражения внутри `{ ... }` и интерполяции строк:

```yuck
(label :text {volume.muted ? "muted" : "${volume.value}%"})
(box :class {battery.capacity <= 15 ? "battery critical" : "battery normal"})
```

JSON-доступ:
```yuck
object.field
array[0]
object["field"]
```

Безопасный доступ (`?.`):
```yuck
object?.field
array?.[0]
```

JSON-доступ работает только если переменная содержит валидный JSON.

```yuck
(defpoll volume_json :interval "2s" "~/.config/eww/scripts/volume.sh")

(defwidget volume []
  (box :class "module volume ${volume_json?.class ?: "unknown"}"
    (label :text {volume_json?.text ?: "vol ?"})))
```

Если версия Eww не поддерживает JSON-доступ — упрости до текста или раздели на переменные.

---

## Built-in widgets

Layout: `box`, `centerbox`, `overlay`, `stack`, `literal`

UI: `label`, `button`, `eventbox`, `image`, `scale`, `progress`, `circular-progress`, `graph`, `calendar`, `systray`

`literal` — только когда динамическая генерация Yuck действительно нужна. Он мощный, но усложняет отладку.
