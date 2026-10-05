# defaultapps

Stow-пакет: дефолтные приложения для river/Wayland и сопутствующие обёртки.

## Установка

```sh
cd ~/dotfiles && stow -t ~ defaultapps
# после установки/обновления .desktop-файлов:
update-desktop-database ~/.local/share/applications
```

На чистой машине (когда `~/.config` и `~/.local` ещё не существуют) stow по умолчанию
свернёт каталоги в один симлинк `~/.config -> defaultapps/.config`, и потом туда уже
не встанут другие пакеты (`nvim`, `zed`, …). Чтобы этого не было — ставить с
`--no-folding`:

```sh
cd ~/dotfiles && stow --no-folding -t ~ defaultapps
```

## Что ставится

| Путь в $HOME | Назначение |
|---|---|
| `.config/mimeapps.list` | ассоциации: текст/код → nvim в foot, видео/аудио → mpv, pdf/epub → zen, каталоги → yazi, картинки → imv |
| `.local/bin/foot-run` | запуск команды в окне foot (переиспользует foot-сервер через `footclient`, иначе поднимает отдельный `foot`) |
| `.local/bin/xdg-open` | обёртка: сначала `gio open`, при неудаче — системный `/usr/bin/xdg-open` |
| `.local/share/applications/nvim-foot.desktop` | nvim в foot для `text/*`, кода, конфигов |
| `.local/share/applications/yazi.desktop` | yazi в foot для `inode/directory` (переопределяет системный с `Terminal=true`) |

## Зачем нужны обёртки

**`xdg-open`.** При `XDG_CURRENT_DESKTOP=river` системный `/usr/bin/xdg-open` уходит
в legacy-ветку `open_generic`, которая **не наследует MIME-подтипы**. Практический
эффект: `.py` в shared-mime-info — это `text/x-script.python`, обработчика для него
нет, наследования до `text/plain` тоже нет, и файл улетает в браузер.
`gio open` наследование умеет, поэтому обёртка сначала пробует его.

**`yazi.desktop`.** Файл из пакета `yazi` имеет `Terminal=true` (`Exec=yazi %f`).
GIO отказывается его запускать: `Unable to find terminal required for application`
(в сеансе нет зарегистрированного терминала). Свой desktop-файл с `Terminal=false`
и `Exec=foot-run yazi %f` решает проблему.

## Нюансы

- **GLib игнорирует дефолт, если бинарь из `Exec=` не найден в `PATH`.** Поэтому
  ассоциации на `imv.desktop` начнут работать только после `yay -S imv`.
- `gio open` наследует MIME-подтипы, а `gio mime <тип>` и `xdg-mime query default` —
  **нет**. Для диагностики использовать `gio open`, а не запрос дефолта.
- В `.local/bin/xdg-open` предполагается, что `~/.local/bin` есть в `PATH` (у fish
  он там есть).
- Ассоциации для `text/x-script.python` решаются наследованием в `gio open`;
  `mimeapps.list` перечисляет конкретные типы явно — это подстраховка на случай
  инструментов, которые точное совпадение проверяют без наследования.
- **`mimeapps.list` — симлинк (stow создаёт только относительные ссылки), и
  `gio mime <тип> <приложение>` на такой ссылке падает:**
  `Failed to create file "../dotfiles/.../mimeapps.list.XXXXXX": No such file or directory`.
  Симлинк при этом не портится, просто изменение не применяется. Менять дефолты
  надо через `xdg-mime default <app.desktop> <mime/type>` — он пишет сквозь симлинк,
  либо просто править файл в репозитории. Абсолютную ссылку stow перестаёт
  отслеживать (`Ignoring an absolute symlink` при `stow -D`), поэтому так делать не надо.
