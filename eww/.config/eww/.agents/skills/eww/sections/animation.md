# Animation rules

Eww поддерживает простые анимации. Ожидания — реалистичные.

Предпочитаемые механизмы:
1. `revealer` — показать/скрыть потомка;
2. `stack` — переключение между потомками;
3. CSS-переходы — простые hover/focus;
4. `transform` — rotate/translate/scale.

## Revealer

Для инлайн-панелей, контента попапов, меню, slide-down секций.

Не используй `revealer` как единственный механизм скрытия постоянного Wayland-попапа — окно всё равно перехватывает клики.

```yuck
(defvar show_calendar false)

(defwidget calendar_popup []
  (revealer
    :reveal show_calendar
    :transition "slidedown"
    :duration "200ms"
    (box :class "popup calendar-popup"
      (calendar))))
```

Поддерживаемые transition: `slideright`, `slideleft`, `slideup`, `slidedown`, `crossfade`, `none`.

## Stack

Для переключения видимого контента:

```yuck
(defvar active_page 0)

(defwidget dashboard []
  (stack
    :selected active_page
    :transition "crossfade"
    :same-size true
    (box (label :text "System"))
    (box (label :text "Media"))
    (box (label :text "Power"))))
```

## Transform

```yuck
(transform
  :rotate 5
  :scale-x "1.05"
  :scale-y "1.05"
  (label :text "Hi"))
```

Не используй Eww для браузероподобных анимаций, keyframe-heavy UI, больших анимированных дашбордов.
