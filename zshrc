# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM="xterm-256color"

autoload -U +X compinit && compinit 
autoload -U +X bashcompinit && bashcompinit 
# autoload -U zmv
# autoload -U zcalc
source ~/.antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle extract
antigen bundle history
antigen bundle screen
antigen bundle sublime
antigen bundle sudo
antigen bundle colored-man-pages
antigen bundle zsh-users/zsh-completions src
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle virtualenv
antigen bundle virtualenvwrapper

antigen theme romkatv/powerlevel10k

antigen apply

bindkey -e 
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

#setopt nocorrectall

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS=true
DISABLE_UNTRACKED_FILES_DIRTY="true"

DEFAULT_USER=`whoami`

#alias subl='/opt/sublime_text/sublime_text'
#alias jabref='java -jar /home/tibo/Downloads/JabRef-4.1.jar'
#alias vsim='/opt/intelFPGA_lite/18.0/modelsim_ase/linuxaloem/vsim'
#alias cat='bat'

#export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
#export LIBRARY_PATH=/usr/local/cuda/lib64:$LIBRARY_PATH
#export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
#export PATH=/usr/local/cuda/bin:$PATH:/home/tibo/.local/bin
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intelFPGA_lite/18.0/modelsim_ase/lib 

alias -s {mpg,mpeg,avi,ogm,wmv,m4v,mp4,mov,mkv}='vlc'
alias -s {cpp,c,h,hpp,hxx,vhd,tex}='subl'
alias -s pdf='evince'

#source /opt/intel/mkl/bin/mklvars.sh intel64
 

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#export GEM_HOME=$HOME/gems
#export PATH=$HOME/gems/bin:$PATH

#if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#        source /etc/profile.d/vte.sh
#fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#GITSTATUS_DAEMON=~/powerlevel10k/gitstatus/bin/gitstatusd-linux-x86_64-static
