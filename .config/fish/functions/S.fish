function S --wraps='pacman -S' --wraps='sudo pacman -S' --description 'alias S=sudo pacman -S'
  sudo pacman -S $argv
        
end
