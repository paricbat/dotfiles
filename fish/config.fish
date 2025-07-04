fish_add_path ~/.local/bin
fish_add_path ~/.local/bin/pulumi
fish_add_path ~/.local/bin/omnisharp

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
end

# pnpm
set -gx PNPM_HOME "/var/home/paricbat/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
