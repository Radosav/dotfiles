# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/radosav/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Use on .sql files as "fixsql somedump.sql"
fixsql(){
    echo -n "Fixing '$argv[1]' ... "
    sed -i 's/ROW_FORMAT=FIXED//g;s/DEFINER\s*=\s*[^*]*//g' $1
    echo "done."
}

# Use to install/update extension as "update {PROJECT_NAME}" from extension magento root
# Change projects folder path if needed (line 3)
update(){
    find . -type f -exec touch {} ;\
    rsync -azP . ~/projects/$1/
}

# Creates admin user for M2, change username and password to your prefference
createadminuser2(){
    n98-magerun2.phar admin:user:create --admin-user="rasa" --admin-firstname="a" --admin-lastname="b" --admin-email="a@gmail.com" --admin-password="archer227"
}

# cd to projects frolder, change path if needed 
alias cdp='cd ~/projects'
# set correct permissions for M2
alias m2perms='find var vendor pub/static pub/media app/etc -type f -exec chmod u+w {} \; && find var vendor pub/static pub/media app/etc -type d -exec chmod u+w {} \; && chmod u+x bin/magento'
# cd to project root ( git root )
alias cdr='cd "$(git rev-parse --show-cdup)"'
# flush caches from anywhere in project
alias rmc='pushd . >/dev/null;cd "$(git rev-parse --show-cdup)";rm -rf var/cache;echo "cleared cache in $(pwd)/var/cache";popd>/dev/null;'
# Pretty git log
alias glp='git log --graph --full-history --all --color --pretty=format:"%Cred[%d ] %Cgreen%p -> %h %Cblue%cn(%ce) %Cred%s %n"'
