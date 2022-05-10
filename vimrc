" Plug-Vim Plugin reference: https://www.vimfromscratch.com/articles/vim-for-python
call plug#begin('~/.vim/plugged')
	Plug 'preservim/nerdtree'
	Plug 'Vimjas/vim-python-pep8-indent'
	Plug 'tpope/vim-commentary'
	Plug 'junegunn/fzf.vim'
	Plug 'liuchengxu/vista.vim'
	Plug 'jeetsukumaran/vim-pythonsense'
	Plug 'jiangmiao/auto-pairs'
	Plug 'joshdick/onedark.vim'
	Plug 'sheerun/vim-polyglot'
	Plug 'dense-analysis/ale'
	Plug 'davidhalter/jedi'
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Some basics:
	set nocompatible
	filetype indent on
	set encoding=utf-8
	set number relativenumber

" Split navigations
	nnoremap <C-J> <C-W><C-J>
	nnoremap <C-K> <C-W><C-K>
	nnoremap <C-L> <C-W><C-L>
	nnoremap <C-H> <C-W><C-H>

" NERDTree (A way to view the file tree in vim)
	nnoremap <leader>n :NERDTreeFocus<CR>
	nnoremap <C-n> :NERDTree<CR>
	nnoremap <C-t> :NERDTreeToggle<CR>

" Ale (linter and fixer)
let g:ale_linter = {
			\	'python': ['flake8', 'pylint'],
			\ 'shell': ['shellcheck']
			\}
let g:ale_fixer = {
			\ 'python': ['yapf'],
			\}

nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1

" turn on the syntax checker
syntax on

" error symbol to use in sidebar
let g:ale_sign_error = '☢️'
let g:ale_sign_warning = '⚡'

" show number of errors
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? 'OK' : printf(
        \   '%d⨉ %d⚠ ',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set laststatus=2
set statusline+=%=
set statusline+=\ %{LinterStatus()}

" format error strings
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Polyglot
let g:python_highlight_all = 1

" Onedark
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

colorscheme onedark

" Congquer of completion (coc)
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Display Documentation (in floating window)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
	if (index(['vim', 'help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" Folding functions
"au BufNewFile,BufRead *.py\
"	set foldmethod=indent

"nnoremap <space> za


