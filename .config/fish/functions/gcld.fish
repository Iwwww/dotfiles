function gcld --wraps='git clone --depth=1' --description 'alias gcld=git clone --depth=1'
  git clone --depth=1 $argv
        
end
