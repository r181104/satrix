set nocompatible
syntax enable
filetype on
filetype indent on
set hidden
set ttyfast
set lazyredraw
colorscheme ron
colorscheme retrobox
highlight Normal guibg=black ctermbg=black

if has('gui_running')
  set transparency=9
else
endif
set termguicolors
if !has('gui_running')
  set t_Co=256
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
endif

set number
set relativenumber
set cursorline
set cursorcolumn
set scrolloff=8
set sidescrolloff=8
set wrap
set linebreak
set showcmd
set showmatch
set signcolumn=yes
set virtualedit=block
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set cindent
set autoindent
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan
set noswapfile
set undofile
set undodir=~/.vim/undo
set updatetime=50
set synmaxcol=500
set ttimeoutlen=10

let mapleader=" "

nnoremap <silent> <leader>h :nohl<CR>
nnoremap <leader>e :Explore<CR>
nnoremap <leader>? :echo "Space-w: Save\nSpace-q: Quit\njk: Escape\nSpace-y: Yank\nSpace-t: Terminal\nSpace-l: Toggle list\nCtrl+hjkl: Window nav"<CR>

nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bd :bdelete<CR>

nnoremap <leader>sv <C-w>v<C-w>l
nnoremap <leader>sh <C-w>s
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap Y y$
nnoremap n nzzzv
nnoremap N Nzzzv
vnoremap <leader>y :w !xclip -sel clip<CR><CR>
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>

inoremap jk <Esc>
vnoremap jk <Esc>
cnoremap jk <C-c>
tnoremap jk <C-\><C-n>

nnoremap <leader>t :terminal<CR>
tnoremap <Esc> <C-\><C-n>

nnoremap <leader>l :set list!<CR>

function! ToggleComment()
  let comment_map = {
        \ 'vim': '"',
        \ 'python': '#',
        \ 'sh': '#',
        \ 'nix': '#',
        \ 'zsh': '#',
        \ 'javascript': '//',
        \ 'typescript': '//',
        \ 'c': '//',
        \ 'cpp': '//',
        \ 'go': '//',
        \ 'lua': '--',
        \ 'sql': '--',
        \ 'ruby': '#',
        \ 'yaml': '#',
        \ 'conf': '#',
        \ 'fstab': '#',
        \ 'bash': '#',
        \ 'make': '#',
        \ 'cmake': '#'
        \ }

  let comment = get(comment_map, &filetype, '#')
  let regex = '^\s*' . comment . '\s\?'
  let line = getline('.')

  if line =~ regex
    execute 's/' . regex . '//'
  else
    execute 's/^/' . comment . ' /'
  endif
endfunction

nnoremap gcc :call ToggleComment()<CR>
vnoremap gc :call ToggleComment()<CR>

augroup vimrc_autocmds
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
  autocmd BufWritePre * %s/\s\+$//e
augroup END

set listchars=tab:▸\ ,trail:•,nbsp:+,extends:»,precedes:«
set fillchars=vert:│,fold:·

function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

set wildmode=longest:full,full
set wildignore=*.o,*~,*.pyc,*.class

if has('mouse')
  set mouse=a
endif

autocmd FileType python      setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType javascript  setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType typescript  setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType json        setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType html        setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType css         setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType scss        setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType yaml        setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType ruby        setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType java        setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType c           setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType cpp         setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType go          setlocal shiftwidth=4 tabstop=4 noexpandtab
autocmd FileType rust        setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd FileType lua         setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType sh          setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType zsh         setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType vue         setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType markdown    setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType conf        setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType nix         setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd BufNewFile,BufRead *.rc set filetype=conf
autocmd BufNewFile,BufRead *.nix set filetype=nix

set showtabline=0
let g:currentmode = {
      \ 'n'  : ' NORMAL ',
      \ 'i'  : ' INSERT ',
      \ 'R'  : ' REPLACE ',
      \ 'v'  : ' VISUAL ',
      \ 'V'  : ' V-LINE ',
      \ 'x22': ' V-BLOCK ',
      \ 'c'  : ' COMMAND ',
      \ 't'  : ' TERMINAL '
      \}

function! FileSize()
  let bytes = getfsize(expand('%:p'))
  if bytes <= 0 | return '' | endif

  if bytes >= 1024 * 1024
    return printf('%.1f MB', bytes / (1024.0 * 1024))
  elseif bytes >= 1024
    return printf('%.1f KB', bytes / 1024.0)
  else
    return bytes . ' B'
  endif
endfunction

function! ReadOnly()
  return &readonly || !&modifiable ? '' : ''
endfunction

function! GitIndicator()
  if !empty(finddir('.git', ';'))
    return ' GIT'
  endif
  return ''
endfunction

set laststatus=2
set statusline=
set statusline+=%#StatusLineMode#
set statusline+=\ %{toupper(g:currentmode[mode()])}\
set statusline+=%#StatusLineInfo#
set statusline+=[%n]
set statusline+=\ %<%F
set statusline+=%#StatusLineWarning#
set statusline+=\ %{ReadOnly()}
set statusline+=\ %m
set statusline+=%*

set statusline+=%#StatusLineGit#

set statusline+=%=
set statusline+=\ %{GitIndicator()}
set statusline+=%#StatusLineInfo#
set statusline+=\ %y
set statusline+=\ %{(&fenc!=''?&fenc:&enc)}
set statusline+=\ [%{&ff}]
set statusline+=\ %{FileSize()}
set statusline+=%#StatusLineMode#
set statusline+=\ %3p%%
set statusline+=\ \ %4l:%-3c
set statusline+=\

hi StatusLine          guifg=#abb2bf guibg=#2c323c gui=NONE ctermfg=249 ctermbg=236
hi StatusLineMode      guifg=#e2c08d guibg=#2c323c gui=bold ctermfg=180 cterm=bold
hi StatusLineInfo      guifg=#7aa6da guibg=#2c323c gui=NONE ctermfg=110
hi StatusLineWarning   guifg=#e06c75 guibg=#2c323c gui=bold ctermfg=168 cterm=bold
hi StatusLineGit       guifg=#98c379 guibg=#2c323c gui=italic ctermfg=150 cterm=italic
