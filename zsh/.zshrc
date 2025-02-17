### Zsh Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  direnv
)


### Zsh Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

### Welcome message
figlet -f slant -w 120 '[ welcome, mashu ]' | cowsay -f parrot -n | lolcat -f -S 10

### Aliases
alias ll="ls -la"
alias dc="docker compose"
alias vim="/opt/homebrew/bin/vim"
alias kl="kubectl"
alias vl="vksctl"
alias klc="kubectl config"
alias apm="appium"
alias nv="nvim"
alias tm="tmux"
alias tf="terraform"
alias gui="/usr/local/bin/gitui"

### Use vim keybindings
bindkey -v
bindkey "^R" history-incremental-pattern-search-backward

### Set up Java and Android SDK
export ANDROID_HOME="/Users/mashu/Library/Android/sdk"
#export PATH="${ANDROID_HOME}/bin:${PATH}"

export JAVA_HOME="/Users/mashu/Library/Java/JavaVirtualMachines/graalvm-ce-21.0.2/Contents/Home"
#export PATH="${JAVA_HOME}/bin:${PATH}"

### Set up Golang
#export PATH="/Users/mashu/go/bin:$PATH"
