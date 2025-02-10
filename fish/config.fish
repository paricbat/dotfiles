fish_add_path ~/.local/bin

if status is-interactive
    starship init fish | source
    zoxide init fish | source

    alias ga="git add"
    alias gs="git status"
    alias gd="git diff"
    alias gds="git diff --staged"
    alias find="fd --hidden"
    alias ls="eza -a"
end

