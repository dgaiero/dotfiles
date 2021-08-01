eval $(ssh-agent -s) > /dev/null
alias vncRandR='vncserver -geometry 1920x1080 -depth 16 RandR=1920x1080,1920x1200,3840x2160,7680x2160'
alias autopep82R='autopep8 --in-place --recursive --pep8-passes 2000 --aggressive --aggressive'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias test2='echo test'

alias get_esp32='export PATH=$PATH:$HOME/esp/xtensa-esp32-elf/bin'
