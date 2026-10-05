# Dotfiles

Конфиги для CachyOS + river. Ставятся через [GNU Stow](https://www.gnu.org/software/stow/):
каталог верхнего уровня = пакет.

## Развернуть

```sh
cd ~/dotfiles
stow --no-folding -t ~/.config .config
stow --no-folding -t ~ defaultapps dsh eww lazygit nvim opencode quickshell zed
update-desktop-database ~/.local/share/applications
```

- `--no-folding` — чтобы stow не свернул каталог в один симлинк: иначе `~/.config`
  целиком ссылался бы на репо, и остальные модули туда уже не встанут.
- Автозапуск юнитов настраивается на машине: `systemctl --user enable foot kanshi
  swww-daemon waybar gammastep`, плюс `broot --install`.

## Модули

| Модуль | Куда | Команда |
|---|---|---|
| `.config` | `~/.config` | `stow --no-folding -t ~/.config .config` |
| `defaultapps` | `~` | `stow --no-folding -t ~ defaultapps` |
| `dsh` | `~` | `stow --no-folding -t ~ dsh` |
| `eww` | `~` | `stow --no-folding -t ~ eww` |
| `lazygit` | `~` | `stow --no-folding -t ~ lazygit` |
| `nvim` | `~` | `stow --no-folding -t ~ nvim` |
| `opencode` | `~` | `stow --no-folding -t ~ opencode` |
| `quickshell` | `~` | `stow --no-folding -t ~ quickshell` |
| `zed` | `~` | `stow --no-folding -t ~ zed` |

`.config` ставит fish, foot, fnott, mpv, river, systemd, wal, waybar, wlogout, yazi, zathura;
у `defaultapps` подробности в [его README](defaultapps/README.md).

## Снять

```sh
stow -D --no-folding -t ~ <модуль>
stow -D --no-folding -t ~/.config .config
```
