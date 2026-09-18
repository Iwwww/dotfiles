if status is-interactive
    # Commands to run in interactive sessions can go here
end
zoxide init fish | source

# Раньше лежало в functions/P.fish, но этот файл конфликтовал по регистру с
# functions/p.fish: на Linux это два разных файла, на macOS/APFS — один путь,
# из-за чего рабочее дерево там всегда было «грязным».
function P --wraps='sudo pacman' --description 'alias P=sudo pacman'
  sudo pacman $argv
end
