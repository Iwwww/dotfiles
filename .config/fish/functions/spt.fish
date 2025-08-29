function spt --wraps='source .proxy_env ; /usr/bin/spt' --description 'alias spt=source .proxy_env ; /usr/bin/spt'
  source .proxy_env ; /usr/bin/spt $argv
        
end
