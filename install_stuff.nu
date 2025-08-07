#!/usr/bin/env nu
do -c {
  # Stuff used for installing other stuff
  brew install pnpm node
  curl -LsSf https://astral.sh/uv/install.sh | sh;
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y;

  # Tools
  brew install helix eza bat zoxide starship git-lfs sops age
  curl -fsSL https://deno.land/install.sh | sh

  # LSPs
  uv tool install ruff
  pnpm i -g vscode-langservers-extracted
  pnpm i -g @ansible/ansible-language-server
  pnpm i -g dockerfile-language-server-nodejs
  pnpm i -g typescript typescript-language-server
  cargo install taplo-cli --locked --features lsp
  cargo install --git https://github.com/wgsl-analyzer/wgsl-analyzer wgsl-analyzer
  cargo install --locked zellij
}
