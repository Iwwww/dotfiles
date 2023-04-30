function pwdc --wraps='pwd | xclip -selection clipboard' --description 'alias pwdc=pwd | xclip -selection clipboard'
  pwd | xclip -selection clipboard $argv
        
end
