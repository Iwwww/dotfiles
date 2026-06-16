# Data update patterns

## defvar

Для внутреннего состояния:

```yuck
(defvar show_powermenu false)
(defvar active_page 0)
```

Обновление из команд:

```sh
eww update show_powermenu=true
```

Внутри Eww-обработчиков предпочитай `${EWW_CMD}`:

```yuck
(button
  :onclick "${EWW_CMD} update show_powermenu=true"
  (label :text "power"))
```

## defpoll

Для периодического вывода команд:

```yuck
(defpoll battery_json :interval "30s" "~/.config/eww/scripts/battery.sh")
```

Используй когда данные меняются периодически и не нуждаются в мгновенных event-driven обновлениях.

## deflisten

Для потоков событий:

```yuck
(deflisten media_json :initial '{"text":"","class":"stopped"}' "~/.config/eww/scripts/media-listen.sh")
```

Используй когда скрипт может жить долго и выдавать новые значения только при изменениях.

Хорошие кандидаты: медиа-плеер, workspace-изменения, заголовок окна, состояние уведомлений, IPC-потоки.

Не используй `deflisten` для скриптов, которые никогда не выводят или не сбрасывают stdout.
