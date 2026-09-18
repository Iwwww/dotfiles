# Common anti-patterns

**Дорогой polling:**
```yuck
(defpoll cpu :interval "1s" "top -bn1 | grep Cpu | awk ...")
```
→ Используй магические переменные или лёгкий парсинг `/proc`.

**Огромные inline-пайпы:**
```yuck
(defpoll status :interval "1s" "cmd1 | cmd2 | cmd3 | cmd4 | jq ...")
```
→ Вынеси в скрипт:
```yuck
(defpoll status_json :interval "10s" "~/.config/eww/scripts/status.sh")
```

**Хардкод команд композитора:**
```yuck
(button :onclick "hyprctl dispatch workspace 1" ...)
```
→ Используй скрипты-обёртки.

**Сложные `literal`-виджеты без необходимости.**

**CSS как браузерный CSS** — Eww использует GTK CSS.

**Утверждение что конфиг протестирован без реального запуска команд.**
