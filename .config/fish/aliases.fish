# Aliases
alias s='spring'
# alias s='zeus'
# alias vi='/usr/local/Cellar/vim/7.4.884/bin/vim'
alias vi='nvim'
alias hvi='vi -u ~/.dotfiles/vim/.vimrc.haskell'
alias hvim='hvi'
alias rvi='vi -u ~/.dotfiles/vim/.vimrc.ruby'
alias rvim='rvi'
alias tivi='vi -u ~/.dotfiles/vim/.vimrc.titanium'
alias tivim='tivi'
alias ardvi='vi -u ~/.dotfiles/vim/.vimrc.arduino'
alias ardvim='ardvi'
alias ctags="`brew --prefix`/bin/ctags"
alias redis-start='sudo launchctl start io.redis.redis-server'
alias redis-stop='sudo launchctl stop io.redis.redis-server'
alias preparallel='env DISABLE_SPRING=1 rake parallel:prepare'
alias diskusage='ls -al | tail -n +2 | awk \'{ print substr($0, index($0,$9)) }\' | sed "s/;/\";\"/g;s/^/\"/;s/\$/\"/" | grep -v \'^"[\.]\+"$\' | xargs -L 1 sudo du -sh 2>/dev/null | gsort -hr'
alias gs='git status'
alias ga='git add'
alias gcm='git commit -m'
alias gco='git checkout'
alias fiveman='foreman start -f Procfile.dev'

# function zeus; set ARGS $argv; command zeus "$argv"; set ZE_EC $status; stty sane; if [ $ZE_EC = 2 ]; zeus "$ARGS"; end; end
function fixed_zeus; set ARGS $argv; command zeus $argv; set ZE_EC $status; stty sane; if [ $ZE_EC = 2 ]; fixed_zeus $ARGS; end; end
function guard; stty sane; command guard $argv; end

function set_profile
  echo -e "\033]50;SetProfile=$argv\a"
end
function chill
  set_profile "Default"
end

# Heroku Functions
function hprod
  set_profile "GSC Production"
  heroku $argv -r production
  chill
end
function hstag
  set_profile "GSC Staging"
  heroku $argv -r staging
  chill
end
function hreview
  set_profile "GSC Review"
  heroku $argv -r review
  chill
end
function htool
  set_profile "Ops Toolkit Production"
  heroku $argv -a ops-toolkit
  chill
end
function hwhite
  set_profile "GSC White"
  heroku $argv white -a gospotcheck-production
  chill
end
function hqa
  set_profile "GSC QA"
  heroku $argv -r qa
  chill
end

function install_haskell_executables
  stack build
  cp (stack path --local-install-root)/bin/* /usr/local/bin/
end

function yolo
  bash -lc 'yolo "$@"' _ $argv
end

function jqr
  jq "$argv[1..-2]" "$argv[-1]" > ".temp.$argv[-1]"
  mv ".temp.$argv[-1]" "$argv[-1]"
end

# From: https://blog.hospodarets.com/fish-shell-the-missing-config
# REUSE ALIASES FROM ~/.bash_profile
egrep "^alias " ~/.bash_profile | while read e
        set var (echo $e | sed -E "s/^alias ([A-Za-z0-9_-]+)=(.*)\$/\1/")
        set value (echo $e | sed -E "s/^alias ([A-Za-z0-9_-]+)=(.*)\$/\2/")

        # remove surrounding quotes if existing
        set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

    # evaluate variables. we can use eval because we most likely just used "$var"
        set value (eval echo $value)

    # set an alias
    alias $var="$value"
end

# REUSE ENVIRONMENT VARIABLES FROM ~/.bash_profile
egrep "^export " ~/.bash_profile | while read e
    set var (echo $e | sed -E "s/^export ([A-Z0-9_]+)=(.*)\$/\1/")
    set value (echo $e | sed -E "s/^export ([A-Z0-9_]+)=(.*)\$/\2/")

    # remove surrounding quotes if existing
    set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

    if test $var = "PATH"
        # replace ":" by spaces. this is how PATH looks for Fish
        set value (echo $value | sed -E "s/:/ /g")

        # use eval because we need to expand the value
        eval set -xg $var $value

        continue
    end

    # evaluate variables. we can use eval because we most likely just used "$var"
    set value (eval echo $value)

    #echo "set -xg '$var' '$value' (via '$e')"

    switch $value
            case '`*`';
            # executable
            set NO_QUOTES (echo $value | sed -E "s/^\`(.*)\`\$/\1/")
            set -x $var (eval $NO_QUOTES)
        case '*'
            # default
            set -xg $var $value
        end
end

function create_npm_project
  mkdir $argv[1]
  cd $argv[1]

  git init
  wget https://raw.githubusercontent.com/github/gitignore/master/Node.gitignore -O .gitignore
  wget https://gist.github.com/wolfeidau/8748317/raw/172a6adb79777676a8815da5719ef659fb66a35b/Makefile

  make skel

  npm init -y

  # Babel, Mocha, Chai
  npm install --save-dev babel-core babel-cli babel-preset-es2015
  npm install --save-dev mocha chai

  jqr '.scripts.test="mocha --compilers js:babel-core/register --require ./test/test_helper.js --recursive ./test/**/{,**/}*.js"' package.json
  echo -e '{\n  "presets": ["es2015"]\n}' > .babelrc
  echo -e "require('babel-register')();\n\nimport chai from 'chai';\n" > test/test_helper.js

  # Immutable
  # npm install --save immutable
  # npm install --save-dev chai-immutable
  # echo -e "import chaiImmutable from 'chai-immutable';\n\nchai.use(chaiImmutable);\n" >> test/test_helper.js

  git add .
  git commit -m 'Initial commit'

  npm test
end

function create_pull_request
  if test (count $argv) -eq 0
    echo "Must specify a story number"
  else
    set -l branch (git rev-parse --abbrev-ref HEAD)
    echo "Pushing and creating Pull Request for $branch..."
    git push --set-upstream origin $branch
    sleep 1

    set -l story (string replace -a '#' '' $argv[1])
    set -l title $branch
    if test (count $argv) -eq 2
      set title $argv[2]
    end

    set -l current_project (string split -r -m1 / (pwd))[2]

    set -l pr_url (curl -H "Authorization: bearer $GITHUB_API_TOKEN" -X POST -d "
    \
    { \
      \"title\": \"$title\",
      \"body\": \"**Story:** https://www.pivotaltracker.com/story/show/$story\",
      \"head\": \"$branch\",
      \"base\": \"master\"
    } " https://api.github.com/repos/gospotcheck/$current_project/pulls | jq -r '.html_url')

    echo "PR created at: $pr_url"
    /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome $pr_url
  end
end
