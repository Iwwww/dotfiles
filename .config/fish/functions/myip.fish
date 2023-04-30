function myip --wraps='wget -qO- eth0.me' --description 'alias myip=wget -qO- eth0.me'
  wget -qO- eth0.me $argv
        
end
