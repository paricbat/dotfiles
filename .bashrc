if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

export GPG_TTY=$(tty)

function mkenter() {
	mkdir -pv $1
	cd $1
}

# git fetch merge
function git-fm() {
	git fetch upstream
	git merge upstream/$1
}


alias hd=hexdump

export PATH="/home/paricbat/.cargo/bin:$PATH"
export LIBCLANG_PATH=$(llvm-config --prefix)/lib64

