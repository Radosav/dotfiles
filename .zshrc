# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/home/radosav/.oh-my-zsh

# Disable dead.letter generation
export DEAD=/dev/null

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

# Use on .sql files as "fixsql somedump.sql"
pullproject(){
    echo -n "Pulling from '$argv[1]' ... "
    mkdir $argv[2];
    cd $argv[2];
    mkdir dumps;
    mkdir docs;
    mkdir extensions;
    git clone $agrv[1] public;
    echo "done."
}

# cd to projects frolder, change path if needed 
cpd(){
    
}
alias cdp='cd ~/projects'

# Changes database values to work on local
# Works for M2 and M1
localizedb(){
    user="root"
    database=$1
    url=$2
    core_config_data_raw="core_config_data"
    core_config_data=$3$core_config_data_raw
    ext=".local.com/"
    echo $(mysql $database -u$user<<<"select * from $core_config_data where path like \"%base_url%\";")
    echo $(mysql $database -u$user<<<"update $core_config_data set value=\"http://$url$ext\" where path like \"%base_url%\";")
    echo $(mysql $database -u$user<<<"select * from $core_config_data where path like \"%base_url%\";")

    echo $(mysql $database -u$user<<<"select * from $core_config_data where path like \"%web/seo%\";")
    echo $(mysql $database -u$user<<<"update $core_config_data set value=0 where path like \"%web/seo%\";")
    echo $(mysql $database -u$user<<<"select * from $core_config_data where path like \"%web/seo%\";")

    echo "Database localized!"
}

# Use to install/update extension as "update {PROJECT_NAME}" from extension magento root
# Change projects folder path if needed (line 3)
update(){
    find . -type f -exec touch {} ;\
    rsync -azP --exclude '.git' --exclude '.gitignore' . ~/projects/$1/
}

# Creates admin user for M2, change username and password to your prefference
m2createadminuser(){
    n98-magerun2.phar admin:user:create --admin-user="rasa" --admin-firstname="radosav" --admin-lastname="brajic" --admin-email="rasabrajic@gmail.com" --admin-password="archer227"
}

m2install(){
    php56 bin/magento setup:install --db-name="{$1}" --db-user="root" --db-password="{$2}"  --admin-user="admin" --admin-password="12qwaszx" --admin-email="a@a.com" --admin-firstname="Developer" --admin-lastname="Younify" --cleanup-database --use-sample-data

}

removeSpaces(){
    for d in ./*/ ; do (cd "$d" && for file in *; do mv -v "$file" "$(echo $file | sed 's/\s/_/g')" ; done); done
}

# Total regeneration of M2 website;
alias regenm2='rm -rf var/cache var/generation var/page_cache var/view_preprocessed; bin/magento cache:flush; bin/magento setup:upgrade; bin/magento setup:static-content:deploy nl_NL en_US'


# set correct permissions for M2
alias m2perms='find var vendor pub/static pub/media app/etc -type f -exec chmod u+w {} \; && find var vendor pub/static pub/media app/etc -type d -exec chmod u+w {} \; && chmod u+x bin/magento'

# cd to project root ( git root )
alias cdr='cd "$(git rev-parse --show-cdup)"'

# flush caches from anywhere in project
alias rmc='pushd . >/dev/null;cd "$(git rev-parse --show-cdup)";rm -rf var/cache;echo "cleared cache in $(pwd)/var/cache";popd>/dev/null;'

alias bmsu=' bin/magento setup:upgrade; '
alias bmcf=' bin/magento cache:flush; '
alias bmsscd='bin/magento setup:static-content:deploy nl_NL en_US'
alias bmir='bin/magento indexer:reindex;'
alias bmsdc='bin/magento setup:di:compile;'
alias tmux='
tmux new-session -d "cd ~/projects;vim"
set -g window-active-style "bg=black";
tmux splitw -v -p 30;
tmux selectp -t 1;
tmux splitw -h;
tmux selectp -t 0;
tmux -2 attach-session -d;
'
alias hosts='sudo vim /etc/hosts'

xmodmap ~/.Xmodmap

# Pretty git log
alias glp='git log --graph --full-history --all --color --pretty=format:"%Cred[%d ] %Cgreen%p -> %h %Cblue%cn(%ce) %Cred%s %n"'
