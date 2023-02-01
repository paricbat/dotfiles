" disable netrw
let g:loaded_netrw=1
let g:loaded_netrwPlugin=1

" vim options
set termguicolors
set relativenumber
set number
set showmode
set tabstop=8
set mouse=
set nobackup
set nowritebackup
set nowrap

" vim-plug plugins
call plug#begin()

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'itchyny/lightline.vim'
Plug 'nvim-tree/nvim-web-devicons' " optional, for file icons
Plug 'nvim-tree/nvim-tree.lua'
Plug 'f-person/git-blame.nvim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'jdhao/whitespace.nvim'

call plug#end()

" plugin related vim options
colorscheme catppuccin-frappe
let g:lightline = {'colorscheme': 'catppuccin'}
set signcolumn=yes " CoC requires this

call v:lua.require('nvim-tree').setup()
" Make nvim-tree appear and jump back to main window
autocmd VimEnter * call _nvimtree()
function _nvimtree()
	NvimTreeToggle
	sleep 100ms
	wincmd l
endfunction

" git blame
hi GitBlame guifg=#7b7b7b
let g:gitblame_date_format = '%d.%m.%y %H:%M'
let g:gitblame_highlight_group = 'GitBlame'
let g:gitblame_message_when_not_committed = 'You: Uncommitted changes'
let g:gitblame_message_template = '   <author> (<committer>), <date> <sha> • <summary>'

" CoC
"confirm coc-suggestion with tab
imap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"
"ctl-space to show suggestions
imap <silent><expr> <c-space> coc#refresh()

"show documentation with ctrl+k
nmap <silent><c-k> :call ShowDocumentation()<CR>

"show documentation if it's available
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

