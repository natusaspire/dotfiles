set nocompatible

filetype off

call plug#begin('~/.vim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'scrooloose/nerdtree'
Plug 'itchyny/lightline.vim'
Plug 'kien/ctrlp.vim'
Plug 'junegunn/fzf', {'do': {-> fzf#install()}}
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'dense-analysis/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', {
\  'branch': 'release/1.x',
\  'do': 'yarn install',
\  'for': [
\    'javascript',
\    'typescript',
\    'css',
\    'less',
\    'scss',
\    'json',
\    'graphql',
\    'markdown',
\    'vue',
\    'yaml',
\    'html',
\  ],
\}
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'mattn/emmet-vim'
Plug 'cakebaker/scss-syntax.vim'

call plug#end()

filetype plugin indent on

syntax enable

set number
set signcolumn=yes
set ruler
set nowrap
set showcmd
set wildmenu

set splitbelow
set splitright

set lazyredraw
set ttyfast

set mouse=a

set encoding=utf-8

set listchars=tab:○•,space:·,trail:~,extends:>,precedes:<
set list

set ignorecase
set smartcase
set incsearch
set hlsearch

set tabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent

set colorcolumn=80,100,120

set laststatus=2

set clipboard=unnamed

set updatetime=100

colorscheme onedark

hi Normal ctermbg=NONE guibg=NONE
hi Terminal ctermbg=NONE guibg=NONE

autocmd VimEnter * call SetupLightlineColors()

function SetupLightlineColors() abort
  let l:palette = lightline#palette()

  let l:palette.normal.middle = [['NONE', 'NONE', 'NONE', 'NONE']]
  let l:palette.inactive.middle = l:palette.normal.middle
  let l:palette.tabline.middle = l:palette.normal.middle

  call lightline#colorscheme()
endfunction

command! -bang -nargs=* Rg
\  call fzf#vim#grep(
\    'rg --hidden --glob=!.git --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
\    fzf#vim#with_preview(), <bang>0)

let NERDTreeShowHidden = 1

let g:ctrlp_show_hidden = 1

let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

let g:coc_global_extensions = [
\  'coc-tsserver',
\  'coc-eslint',
\  'coc-tslint-plugin',
\  'coc-json',
\  'coc-html',
\  'coc-css',
\]

let g:prettier#autoformat = 0

let g:lightline = {
\  'colorscheme': 'onedark',
\  'active': {
\    'left': [
\      ['mode', 'paste'],
\      ['gitbranch', 'readonly', 'filename', 'modified'],
\    ],
\  },
\  'component_function': {
\    'gitbranch': 'FugitiveHead',
\  },
\}

map <C-h> <C-w><Left>
map <C-j> <C-w><Down>
map <C-k> <C-w><Up>
map <C-l> <C-w><Right>

tnoremap <C-h> <C-w>h
tnoremap <C-j> <C-w>j
tnoremap <C-k> <C-w>k
tnoremap <C-l> <C-w>l

tnoremap <C-\> <C-\><C-n>

nmap <leader>gs :G<CR>

nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>

inoremap <silent><expr> <C-\> coc#refresh()

nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ac <Plug>(coc-codeaction)

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> <leader><leader> :NERDTreeToggle<CR>

inoremap ( ()<Left>
inoremap (; ();<Left><Left>
inoremap (, (),<Left><Left>
inoremap (: ():<Left><Left>

inoremap (<CR> (<CR>)<Esc>O
inoremap (;<CR> (<CR>);<Esc>O
inoremap (,<CR> (<CR>),<Esc>O
inoremap (:<CR> (<CR>):<Esc>O

inoremap (( (

inoremap [ []<Left>
inoremap [; [];<Left><Left>
inoremap [, [],<Left><Left>

inoremap [<CR> [<CR>]<Esc>O
inoremap [;<CR> [<CR>];<Esc>O
inoremap [,<CR> [<CR>],<Esc>O

inoremap [[ [

inoremap { {}<Left>
inoremap {; {};<Left><Left>
inoremap {, {},<Left><Left>

inoremap {<Space> {<Space><Space>}<Left><Left>
inoremap {<Space>; {<Space><Space>};<Left><Left><Left>
inoremap {<Space>, {<Space><Space>},<Left><Left><Left>

inoremap {<CR> {<CR>}<Esc>O
inoremap {;<CR> {<CR>};<Esc>O
inoremap {,<CR> {<CR>},<Esc>O

inoremap {{ {

inoremap ' ''<Left>
inoremap '; '';<Left><Left>
inoremap ', '',<Left><Left>
inoremap ': '':<Left><Left>

inoremap '' '

inoremap " ""<Left>
inoremap "; "";<Left><Left>
inoremap ", "",<Left><Left>
inoremap ": "":<Left><Left>

inoremap "" "
