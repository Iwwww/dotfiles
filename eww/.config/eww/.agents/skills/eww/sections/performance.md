# Performance rules

Eww выбирают за низкое потребление ресурсов. Сохраняй это преимущество.

## Polling intervals

Консервативные интервалы:

```yuck
(defpoll clock_time :interval "10s" "date '+%H:%M'")
(defpoll clock_date :interval "60s" "date '+%a %d %b'")
(defpoll battery_info :interval "30s" "~/.config/eww/scripts/battery.sh")
(defpoll disk_info :interval "60s" "~/.config/eww/scripts/disk.sh")
(defpoll network_info :interval "5s" "~/.config/eww/scripts/network.sh")
```

`1s` только когда реально нужно: часы с секундами, таймер, индикатор записи, очень отзывчивый медиа-прогресс.

Плохо:
```yuck
(defpoll status :interval "1s" "heavy-command | jq | awk | sed")
```

## Магические переменные (magic variables)

Eww предоставляет встроенные магические переменные:

```yuck
EWW_TIME, EWW_RAM, EWW_DISK, EWW_BATTERY, EWW_CPU, EWW_NET
EWW_CONFIG_DIR, EWW_CMD, EWW_EXECUTABLE
```

- `EWW_TIME` обновляется каждую секунду.
- Остальные обновляются каждые 2 секунды.
- `EWW_DISK` может быть неточным на некоторых ФС.
- Маг. переменные не покрывают все нужды форматирования и композитор-специфики.

```yuck
(defwidget cpu []
  (box :class {EWW_CPU.avg >= 90 ? "module cpu critical" : "module cpu"}
    (label :text "${round(EWW_CPU.avg, 0)}%")))
```

Не оборачивай магические переменные в скрипты без необходимости.
