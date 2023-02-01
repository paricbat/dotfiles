if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

function mkenter() {
	mkdir -pv $1
	cd $1
}

alias hd=hexdump
alias emerge-syup="doas emaint -a sync && doas emerge -auvDN @world"

# git fetch merge
function git-fm() {
	git fetch upstream
	git merge upstream/$1
}

export GPG_TTY=$(tty)

