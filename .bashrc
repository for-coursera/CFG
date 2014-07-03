# DESCRIPTION: bash config file
# AUTHOR: dsjkvf@gmail.com
# NOTE: Please, use it at your own risk


# SET VARIABLES

# Terminal
# export TERM=xterm-256color
if [[ $HOSTANME = VLN_ALEKSANDRAS ]]
then
    export TERM=win32
    export PATH=/c/Users/alex.LINAVA/Documents/My\ Programs/vim/vim73:$PATH
fi
export CLICOLOR=2

# Helpers
export LSCOLORS=cxFxBxDxGxegedDxDxCxCx
export LS_COLORS='di=4;32;40:ln=95;40:pi=40;33:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=01;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;36:*.tar=92;40:*.tgz=92;40:*.arj=92;40:*.taz=92;40:*.lzh=92;40:*.lzma=92;40:*.tlz=92;40:*.txz=92;40:*.zip=92;40:*.z=92;40:*.Z=92;40:*.dz=92;40:*.gz=92;40:*.lz=92;40:*.xz=92;40:*.bz2=92;40:*.tbz=92;40:*.tbz2=92;40:*.bz=92;40:*.tz=92;40:*.deb=92;40:*.rpm=92;40:*.jar=92;40:*.war=92;40:*.ear=92;40:*.sar=92;40:*.rar=92;40:*.ace=92;40:*.zoo=92;40:*.cpio=92;40:*.7z=92;40:*.rz=92;40:*.jpg=31;40:*.jpeg=31;40:*.gif=31;40:*.bmp=31;40:*.pbm=31;40:*.pgm=31;40:*.ppm=31;40:*.tga=31;40:*.xbm=31;40:*.xpm=31;40:*.tif=31;40:*.tiff=31;40:*.png=31;40:*.svg=31;40:*.svgz=31;40:*.mng=31;40:*.pcx=31;40:*.mov=31;40:*.mpg=31;40:*.mpeg=31;40:*.m2v=31;40:*.mkv=31;40:*.ogm=31;40:*.mp4=31;40:*.m4v=31;40:*.mp4v=31;40:*.vob=31;40:*.qt=31;40:*.nuv=31;40:*.wmv=31;40:*.asf=31;40:*.rm=31;40:*.rmvb=31;40:*.flc=31;40:*.avi=31;40:*.fli=31;40:*.flv=31;40:*.gl=31;40:*.dl=31;40:*.xcf=31;40:*.xwd=31;40:*.yuv=31;40:*.cgm=31;40:*.emf=31;40:*.axv=31;40:*.anx=31;40:*.ogv=31;40:*.ogx=31;40:*.aac=31;40:*.au=31;40:*.flac=31;40:*.mid=31;40:*.midi=31;40:*.mka=31;40:*.mp3=31;40:*.mpc=31;40:*.ogg=31;40:*.ra=31;40:*.wav=31;40:*.axa=31;40:*.oga=31;40:*.spx=31;40:*.xspf=31;40:*.swp=91;40:*.bak=91;40:*.tmp=91;40:*.txt=33;40:*.doc=33;40:*.rtf=33;40:*.diz=33;40:*.ctl=33;40:*.me=33;40:*.ps=33;40:*.pdf=33;40:*.xml=33;40:*.xsd=33;40:*.xslt=33;40:*.dtd=33;40:*.html=33;40:*.shtml=33;40:*.htm=33;40:*.mail=33;40:*.msg=33;40:*.lsm=33;40:*.po=33;40:*.nroff=33;40:*.man=33;40:*.tex=33;40:*.sgml=33;40:*.css=33;40:*.text=33;40:*.letter=33;40:*.chm=33;40:*.docx=33;40:*.docm=33;40:*.xlsx=33;40:*.xlsm=33;40:*.pptx=33;40:*.pptm=33;40:*.md=33;40:*.mkd=33;40'
export GREP_OPTIONS="--colour=auto"
export PAGER=less
export EDITOR=vim

# Locale
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
#export LC_CTYPE="ru_RU.UTF-8"
export LC_COLLATE="POSIX"
export LC_ALL="en_US.UTF-8"

# Dropbox
if [[ $HOSTNAME == *local ]]
then
    export DROPBOX=~/Documents/.Backup/Dropbox
else
    export DROPBOX=~/Dropbox
fi


# DEFINE FUNCTIONS AND ALIASES

# Screen
alias scr.irc='screen -c ~/.config/screen/.screenrc.irc'
alias scr.lib='screen -c ~/.config/screen/.screenrc.lib'
if [[ $HOSTNAME == *local ]]
then
    alias scr='screen -c ~/.config/screen/.screenrc.local'
    alias scrm='screen -m -c ~/.config/screen/.screenrc.local'
else
    alias scr='screen -c ~/.config/screen/.screenrc.remote'
    alias scrm='screen -m -c ~/.config/screen/.screenrc.remote'
fi
function scr(){
if [[ `screen -ls | grep Sockets` ]]
    then
        scr
    else
        scr -r -d
fi
}

# Prompt
if [[ $HOSTNAME == *local ]]
then
    function prompt ()
    {
        local WHITE="\[\033[0;37m\]"
        local COLOR="\[\033[0;36m\]"
        export PS1="${COLOR}\u on \h ${WHITE}@ ${COLOR}\w>${WHITE} "
    }
    prompt
else
    function prompt ()
    {
        local WHITE="\[\033[1;37m\]"
        local BLUE="\[\033[1;33m\]"
        local GRAY="\[\033[0;37m\]"
        export PS1="${BLUE}\u on \h: ${WHITE}\w>${GRAY} "
    }
    prompt
fi
function blk ()
{
    local WHITE="\[\033[0;30m\]"
    local COLOR="\[\033[0;36m\]"
    export PS1="${COLOR}\u on \h ${WHITE}@ ${COLOR}\w>${WHITE}" 
}

# System
alias free='df -kh'
alias sys='system_profiler SPSoftwareDataType'
alias cfg='vim ~/.bashrc'
alias src='source ~/.bashrc'
alias shut='sudo shutdown now'
alias rest='sudo shutdown -r now'
alias l='less -N -i -m'
alias m='more'
alias g='egrep -i'
# detailed grep
function grp(){
grep -i -A 5 -B 5 $1 *$2
}
# detailed and recursive grep
function grpr(){
grep -i -r -A 5 -B 5 $1 *$2
}
# 'man' to use 'help' database, too
function man(){
/usr/bin/man $@ || (help $@ 2> /dev/null && help $@ | less)
}
# list processes
alias j=jobs
# grep processes
function psg(){
FIRST=`echo $1 | sed -e 's/^\(.\).*/\1/'`
REST=`echo $1 | sed -e 's/^.\(.*\)/\1/'`
ps -A | grep -i "[$FIRST]$REST"
}
alias psm='ps -a -U s'
function mem(){
if [ -f /usr/bin/free ]
    then 
        /usr/bin/free
    else 
        top -l 1 | grep PhysMem | awk '{print "Used: "$8" ["$6"]\nFree: "$10}'
fi
}
# kill processes
alias kil='kill -15'
alias kis='kill -2'
alias kim='kill -1'
alias kid='kill -9'

# Files and directories
alias md='mkdir'
function mdcd ()
{
mkdir -p "$*"
cd "$*"
}
alias del='rm -rf'
alias del-ds='find . -name ".DS_Store" -exec rm {} \;'
alias del-asl='sudo rm -f /private/var/log/asl/*.asl'
function rmv ()
{
    for f in *.$1; do
        newname=${f%.$1}.$2
        mv -i "$f" "$newname"
    done
}
# list directories and files
alias d='LC_COLLATE=C ls -laF --color --group-directories-first'
alias dir='ls -laAFovk'
# filter listings
alias dirg='ls -laAFovk | grep'
# sort by access time
alias dird='ls -laAFovkt'
# produce a tree
alias tree="ls -R | grep ':' | sed -e 's/://' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/' | less"
# size directories and files
alias du='du -h'
# sort directories by access date (BSD-specific)
alias dud='du -hd 1 | sort -k 2'
# sort directories by size (BSD-specific)
alias dus='du -hd 1 | grep [0-9]K | sort -n -k 1 ; du -hd 1 | grep [0-9]M | sort -n -k 1 ; du -hd 1 | grep [0-9]G | sort -n -k 1'

# Filesystem
alias bd='. bd -s'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias t='cd ~/tmp/'
alias td='cd ~/tmp/devel/'
alias usr='cd /usr/local/'
alias usrs='cd ~/usr/local/'
alias drp='cd $DROPBOX'
alias d='cd ~/Downloads/'
alias docs='cd ~/Documents/'
alias desk='cd ~/Desktop/'
if [[ $HOSTNAME == *local ]]
then
    alias p='cd ~/pub/'
    alias pa='cd ~/pub/Applications'
    alias lib='cd /Library/'
    alias libs='cd ~/Library/'
    alias vol='cd /Volumes/'
    alias opt='cd /opt/local/'
else
    alias w='cd /home/s/public_html/'
    alias wp='cd /home/s/public_html/infornography/personal/s/'
    alias wt='cd /home/s/public_html/infornography/personal/s/tmp/'
    alias li='cd /home/s/public_html/lists/'
    alias lt='cd /home/s/public_html/lists/tmp'
fi
if [[ $HOSTNAME = VLN_ALEKSANDRAS ]]
then
    alias "t"="cd ~/Documents/TMP"
fi

alias nfo='touch 00.nfo ; vim 00.nfo' 
alias lst='touch list ; vim list'

# Archivers
alias tarc='tar cWvf'
alias tarx='tar xzvf'
alias rarx='unrar x'
alias paxx='pax -r -f'
alias zipx='unzip'
alias xarx='xar -xf'
alias xarl='xar -tf'
alias arcl='7za l'
alias boml="lsbom -p 'M/?sF'"
alias 7zc="7z a -t7z -r -mx9"
alias 7zp="7z a -t7z -r -mx9 -mhe=on -p"
alias 7zx="7z x"
alias xpic="7z a -tzip -r -mx9"

# Disk images
function dmgc(){
read -p "Enter NAME: " NAME
read -p "Enter SIZE: " SIZE
read -p "Enter SOURCE: " SOURCE
hdiutil create -encryption -stdinpass -fs HFS+J -volname $NAME -size $SIZE -srcfolder $SOURCE $NAME -attach
}
alias dmgx='hdiutil attach -stdinpass'

# Ecryption
function ssl-enc(){
openssl aes-256-cbc -a -salt -in $1 -out $2
}
function ssl-dec(){
openssl aes-256-cbc -d -a -in $1 -out $2
}

# Filesums
function cfv(){
if [ -f 00.sfv ]                                                                                                                           
then                                                                                                                                   
	rm 00.sfv                                                                                                                          
fi                                                                                                                                         
cksfv * > 00.sfv
}
alias sfv='find . -iname "*.sfv" -execdir cksfv -f {} \;'

# Development
alias mce='mcedit'
if [[ $HOSTANME = VLN_ALEKSANDRAS ]]
then
    alias vim="gvim"
fi
alias py='python'

# Personal information management
alias tasks='mvim ~/.config/tasks/tasks'
alias tsk='vim ~/.config/tasks/tasks'

# Media
# music
alias pls='ls -a1 *.[mM][pP]3 > 00.m3u'
alias play='open 00.m3u'
alias cog='open -a Cog.app *'
alias tags='mp3info -r a -x *.mp3'
alias tags-rus='java -jar ~/usr/local/Java/id3iconv-0.2.1.jar -e cp1251'
# pics                            
alias jpg='open *.[jJ][pP][gG]'
alias gif='open *.[gG][Ii][Ff]'
alias png='open *.[pP][nN][gG]'
alias tif='open *.[tT][iI][fF]*'
# movies
alias avi='open *.[aA][vV][iI]'
alias vlc='open -a VLC.app'

# Network
# speedtest
alias spd='~/usr/local/scripts/speedtest-cli --simple --share'
alias spd-srv-l='~/usr/local/scripts/speedtest-cli --list | grep -e Finland -e Sweden -e Germany | m'
alias spd-srv='~/usr/local/scripts/speedtest-cli --simple --share --server'
# proxies
alias prb='~/usr/local/scripts/proxy-boxer-on'
alias prp='~/usr/local/scripts/proxy-pluto-on'
alias prh='~/usr/local/scripts/proxy-hidro-on'
alias prf='~/usr/local/scripts/proxy-off'

# Agents
alias wg='wget -c -nd --no-check-certificate'
# wget as mirror
alias mr='wget -m -np -c'
# wget to use list
alias wgi='wget -c -nd -i list'
# wget to use list and to go to background
alias wgib='wget -c -b -nd -i list'
# wget to use list in HTML-markup
alias wgf='wget -c -nd -F -i list'
# wget to use list in HTML-markup and to go to background
alias wgfb='wget -c -b -nd -F -i list'
# wget to check log
alias save='cat wget-log* | grep save'

# Browsers
alias zorro='/Applications/Firefox.app/Contents/MacOS/firefox -P zorro >& /dev/null &'
alias clean='/Applications/Firefox.app/Contents/MacOS/firefox -P clean >& /dev/null &'

# Connections
alias plt='ssh -D 15000 pluto'
alias box='ssh -D 15000 boxer'
alias hid='ssh -D 15001 hidro'
