# .zshrc

# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

################
# Options
################

# Changing Directories
setopt AUTO_PUSHD           # 自動で pushd する
# Completion
setopt COMPLETE_IN_WORD     # 単語の途中から補完できるようにする
# History
setopt EXTENDED_HISTORY     # 日時情報を付加して履歴を保存する
setopt HIST_IGNORE_SPACE    # 空白で始まる履歴を保存しない
setopt HIST_IGNORE_DUPS     # 重複する履歴を保存しない
setopt HIST_VERIFY          # 履歴呼び出しを直接実行しない
setopt SHARE_HISTORY        # 異るシェルインスタンス間で履歴を共有する
# I/O
unsetopt CLOBBER            # リダイレクト時に既存ファイルを上書きできないようにする
setopt CORRECT              # コマンドのスペルミス訂正をする
setopt CORRECT_ALL          # 引数のスペルミス訂正をする
setopt IGNORE_EOF           # Ctrl-D で終了しない
setopt INTERACTIVE_COMMENTS # 対話モードでもコメントを有効にする
setopt PRINT_EXIT_VALUE     # 終了コードを表示する

################
# Prompt
################
autoload -U colors && colors
PROMPT="%n@%m%# "
PROMPT2="%_%# "
RPROMPT="%(?..%{$fg[red]%}:(%{$reset_color%} )%~ [%D{%y/%m/%d %H:%M:%S}]"
PROMPT_EOL_MARK="%B%S$%s%b"

################
# Aliases
################
alias ls="ls -AbFhkv --color --group-directories-first"
alias ll="ls -l"
alias pacman="pakku --color=auto"
alias xargs="xargs "
alias rm="rm -I"

################

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
bindkey -e

[ -e "/usr/share/doc/pkgfile/command-not-found.zsh" ] && source /usr/share/doc/pkgfile/command-not-found.zsh
[ -e "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#[ -e "~/.dir_colors" ] && eval `dircolors -b ~/.dir_colors`
[ -e "$HOME/.local/etc/proxy.zsh" ] && source "$HOME/.local/etc/proxy.zsh"

# tmux menu
if type tmux > /dev/null && [ -z $TMUX ]; then
	entries=()

	if [ $TERM = "linux" ]; then
		entries+=("startx" "startx")
	fi

	tmux list-session | while read session; do
		session_num=$(sed 's/:.*$//' <<< "$session")
		entries+=($session_num $session)
	done

	entries+=("new" "start new session")
	entries+=("no" "no tmux")

	tmpfile=/tmp/zsh-tmux-menu-$$
	dialog --menu "Welcome" 0 0 0 "${entries[@]}" 2>!$tmpfile
	selected=$(cat $tmpfile)
	rm $tmpfile

	if [ $selected ]; then
		if [ $selected = "startx" ]; then
			export LANG=ja_JP.UTF-8
			exec startx
		elif [ $selected = "new" ]; then
			exec tmux -2 new-session
		elif [ $selected != "no" ]; then
			exec tmux -2 attach -t $selected
		fi
	else
		exit
	fi
fi

# vim: ts=4 sw=4
