function la --wraps=ls --wraps='exa -la' --description 'alias la=exa -la'
  exa -la --icons $argv
end
