# Script rules

Скрипты должны быть быстрыми, детерминированными и защищёнными.

Требования:
- `#!/usr/bin/env sh` если не нужен Bash;
- `set -eu` где применимо;
- проверяй наличие команд;
- выводи компактный текст или валидный JSON;
- избегай циклов (кроме `deflisten`);
- избегай сетевых вызовов без явной нужды;
- не пиши логи постоянно;
- избегай дорогих процессов.

Паттерн хорошего JSON-скрипта:

```sh
#!/usr/bin/env sh
set -eu

if ! command -v pamixer >/dev/null 2>&1; then
  printf '%s\n' '{"text":"vol ?","class":"missing","value":0,"muted":false}'
  exit 0
fi

muted="$(pamixer --get-mute)"
volume="$(pamixer --get-volume)"

if [ "$muted" = "true" ]; then
  printf '{"text":"muted","class":"muted","value":%s,"muted":true}\n' "$volume"
else
  printf '{"text":"%s%%","class":"normal","value":%s,"muted":false}\n' "$volume" "$volume"
fi
```

Сделай скрипты исполняемыми:

```sh
chmod +x ~/.config/eww/scripts/*.sh
```

Проверяй скрипты отдельно перед тем как винить Eww:

```sh
~/.config/eww/scripts/volume.sh
```
