fish_add_path ~/.local/bin
fish_add_path ~/.local/bin/pulumi

if status is-interactive
    set -gx EDITOR hx

    starship init fish | source
    zoxide init fish | source

    alias ga="git add"
    alias gs="git status"
    alias gd="git diff"
    alias gds="git diff --staged"
    alias find="fd --hidden"
    alias ls="eza -a"

    alias npm="pnpm"
end

# Homebrew
fish_add_path (brew --prefix)"/bin"
if test -d (brew --prefix)"/share/fish/completions"
    set -p fish_complete_path (brew --prefix)/share/fish/completions
end
if test -d (brew --prefix)"/share/fish/vendor_completions.d"
    set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

# pnpm
set -gx PNPM_HOME "/var/home/paricbat/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
