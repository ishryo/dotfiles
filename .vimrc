set nocompatible
filetype indent plugin on

if has('vim_starting')
	set runtimepath+=~/.vim/bundle/neobundle.vim
	call neobundle#begin(expand('~/.vim/bundle/'))
	NeoBundleFetch 'Shougo/neobundle.vim'
	NeoBundle 'Shougo/unite.vim'
	NeoBundle 'Shougo/vimproc.vim', {
	\ 'build' : {
	\     'windows' : 'tools\\update-dll-mingw',
	\     'cygwin' : 'make -f make_cygwin.mak',
	\     'mac' : 'make',
	\     'linux' : 'make',
	\     'unix' : 'gmake',
	\    },
	\ }
	NeoBundle 'Shougo/vimshell'
	NeoBundle 'Shougo/neosnippet'
	NeoBundle 'Shougo/neosnippet-snippets'
	NeoBundle 'honza/snipmate-snippets'
	NeoBundle 'spolu/dwm.vim'
	NeoBundle 'Shougo/neocomplete.vim'
	NeoBundle 'miyakogi/seiya.vim'
	NeoBundle 'nanotech/jellybeans.vim'
	call neobundle#end()
endif
highlight Normal ctermbg=none
let g:seiya_auto_enable=1
let g:acp_enableAtStartup=0
let g:neocomplete#enable_at_startup=1
let g:neocomplete#enable_snart_case=1
let g:neocomplete#sources#syntax#min_keyword_length=2
let g:neocomplete#sources#dictionary#dictionaries = {
	\ 'default' : '',
	\ 'vimshell': $HOME.'/.vimshell_hist',
	\ 'scheme' : $HOME.'/.gosh_completion'
	\ }
if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

let g:neosnippet#snippets_directory='~/.vim/bundle/snipmate-snippets/snippets'

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

noremap  <C-o> :Unite file -default-action=tabopen<CR>
let g:input_toggle = 1
function! Inactivate_Fcitx()
	let s:input_status = system("fcitx-remote")
	if s:input_status == 2
		let g:input_toggle = 1
		let l:a = system("fcitx-remote -c")
	endif
endfunction

function! Activate_Fcitx()
	let s:input_status = system("fcitx-remote")
	if s:input_status != 2 && g:input_toggle == 1
		let l:a = system("fcitx-remote -o")
		let g:input_toggle = 0
	endif
endfunction

set ttimeoutlen=150
augroup fcitx
	autocmd!
	autocmd InsertLeave * call Inactivate_Fcitx()
	autocmd InsertEnter * call Activate_Fcitx()
augroup END




filetype plugin indent on
setlocal omnifunc=syntaxcomplete#Complete


colorscheme jellybeans
syntax on

set showcmd
set autoindent
set hidden
set wildmenu
set number
set backspace=2
set ignorecase
set smartcase
set infercase
set incsearch
set hlsearch

set list
set listchars=tab:>-,trail:-,nbsp:%,eol:$

" Checking for typo.
autocmd BufWriteCmd *[,*] call s:write_check_typo(expand('<afile>'))
function! s:write_check_typo(file)
	let writecmd = 'write'.(v:cmdbang ? '!' : '').' '.a:file
	if exists('b:write_check_typo_nocheck')
		execute writecmd
		return
	endif
	let prompt = "possible typo: really want to write to '" . a:file . "'?(y/n):"
	let input = input(prompt)
	if input ==# 'YES'
		execute writecmd
		let b:write_check_typo_nocheck = 1
	elseif input =~? '^y\(es\)\=$'
		execute writecmd
	endif
endfunction

