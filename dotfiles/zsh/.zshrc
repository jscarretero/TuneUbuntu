      source ~/.antigen/antigen.zsh

      # Load the oh-my-zsh's library.
      antigen use oh-my-zsh

      # Bundles from the default repo (robbyrussell's oh-my-zsh). Check them :)
      antigen bundle command-not-found
      antigen bundle git
      antigen bundle git-extras
      antigen bundle git-flow
      # antigen bundle pip
      # antigen bundle pyenv
      # antigen bundle python # what does it do?
      # antigen bundle virtualenvwrapper
      antigen bundle web-search
      antigen bundle colorize

      # Bundles from zsh-users.
      antigen bundle zsh-users/zsh-syntax-highlighting
      antigen bundle zsh-users/zsh-autosuggestions
      antigen bundle zsh-users/zsh-history-substring-search
      #antigen bundle zsh-users/zsh-completions

      # Load the theme.
      #antigen theme agnoster
      antigen theme eastwood

      # Tell antigen that you're done.
      antigen apply

      # Bind keys.
      bindkey "[D" backward-word
      bindkey "[C" forward-word
      bindkey -e
      bindkey '^[[1;9C' forward-word
      bindkey '^[[1;9D' backward-word
      bindkey "^[[H"    beginning-of-line
      bindkey "^[[1;5H" beginning-of-line
      bindkey "^[[F"    end-of-line
      bindkey "^[[1;5F" end-of-line
      #To get bindkeys representation: in a terminal type Ctrl+V, nothing will be shown, then type the key combination

      # Exports.
      export EDITOR='nano'

      # Other.
      source ~/.apt_alias
      source ~/.common_alias
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=black,bold' #fixes guake color clash for zsh-users autosuggestions
      source ~/.environment

      export HISTSIZE=300              #History size
      export SAVEHIST=300              #Saved history size after logout
      #export HISTFILE=~/.zsh_history  #History file (default value)
      setopt INC_APPEND_HISTORY        #Append into history file
      setopt HIST_IGNORE_DUPS          #Save only one command if 2 common are same and consistent
      setopt EXTENDED_HISTORY          #Add timestamp for each entry
