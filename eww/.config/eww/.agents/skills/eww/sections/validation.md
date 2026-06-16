# Validation workflow

После изменений:

```sh
eww daemon
eww reload
eww open mainbar
```

Если окно уже открыто:

```sh
eww reload
eww close mainbar
eww open mainbar
```

Дебаг:

```sh
RUST_LOG=debug eww daemon
```

Валидация скриптов отдельно:

```sh
find ~/.config/eww/scripts -type f -name '*.sh' -exec chmod +x {} \;
~/.config/eww/scripts/volume.sh
~/.config/eww/scripts/battery.sh
```

Проверяй форматирование и ошибки парсинга через `eww reload` после каждого маленького изменения.

---

# Debugging checklist

Когда что-то сломалось:
1. Непарные скобки в `.yuck`;
2. Пропущенные кавычки;
3. Невалидные свойства виджетов;
4. Свойство только для Wayland или только для X11;
5. Пути include;
6. Исполняемость скриптов;
7. Запусти скрипты напрямую;
8. Валидность JSON: `~/.config/eww/scripts/status.sh | jq .`;
9. Слишком частый `defpoll`;
10. `deflisten` скрипт не сбрасывает вывод;
11. Ограничения GTK CSS;
12. Индекс/имя монитора;
13. Команды композитора;
14. Собран ли Eww с Wayland или X11 фичами;
15. Проверь локальный CLI перед незнакомыми командами.
