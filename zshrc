# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## Powerlevel10k
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

## Antigen
source ~/.zsh/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle pip
antigen bundle command-not-found
antigen bundle sudo
antigen bundle colored-man-pages
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
#antigen bundle virtualenv
#antigen bundle virtualenvwrapper
antigen apply

autoload -U zmv
autoload -U zcalc

setopt append_history
setopt share_history
setopt extended_history
setopt histignorealldups
setopt histignorespace
setopt auto_cd
setopt hash_list_all
setopt completeinword
setopt nobeep
setopt noglobdots


ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS=true
DISABLE_UNTRACKED_FILES_DIRTY="true"

DEFAULT_USER=`whoami`

alias -s {mpg,mpeg,avi,ogm,wmv,m4v,mp4,mov,mkv}='vlc'
alias -s {cpp,c,h,hpp,hxx,vhd,tex}='subl'
alias -s pdf='okular'

export PATH=/opt/fpga-toolchain/bin:$PATH
export GHDL_PREFIX=/opt/fpga-toolchain/lib/ghdl
export LM_LICENSE_FILE=1718@10.100.10.55
export VUNIT_MODELSIM_PATH=/opt/Questa/questasim/linux_x86_64
export VIVADO_COMP_LIBS=/home/tibo/Documents/code/vivado_compiled_libs_questa;
export VUNIT_SIMULATOR=modelsim

alias ctags_vhd="find . \( -name '*.vhd' \) -print | xargs ctags"
alias vim="nvim"

PATH="$HOME/.local/bin:$PATH"
