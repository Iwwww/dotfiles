function win11 --wraps='xfreerdp3 /u:user /p:1234 /v:192.168.122.40:3389 /w:1920 /h:1080' --description 'alias win11 xfreerdp3 /u:user /p:1234 /v:192.168.122.40:3389 /w:1920 /h:1080'
  xfreerdp3 /u:user /p:1234 /v:192.168.122.40:3389 /w:1920 /h:1080 $argv
        
end
