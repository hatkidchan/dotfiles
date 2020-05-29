" For classic vim
set encoding=utf-8
set fileencoding=utf-8
set number
set autoindent
set incsearch
set laststatus=2
set ruler
" For gvim
if has("gui_running")
	colorscheme desert
	if has("win32")
		lang en
		set bo=all
		set guifont=Courier_New:h18:cANSI:qDRAFT
	else
		set guifont=Nimbus\ Mono\ L\ Bold\ 18
	endif
endif
" Settings for diff mode
if &diff
	colorscheme desert
	set diffopt+=iwhiteeol
endif
" Scroll only one line for mouse wheel events to get smooth scrolling on touch screens
set mouse=a
map <ScrollWheelUp> <C-Y>
imap <ScrollWheelUp> <C-X><C-Y>
map <ScrollWheelDown> <C-E>
imap <ScrollWheelDown> <C-X><C-E>
set number
set title
set list
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set listchars=tab:┊\ 
set timeoutlen=2500
" Disable removing tabs on skipped empty lines
inoremap <cr> <space><bs><cr>
" Window splitting
nnoremap <C-W>% :vsp<cr>
nnoremap <C-W>" :sp<cr>
nnoremap <C-W>z :res<cr>:vertical res<cr>
" Tabs
nnoremap <C-W><C-T> :tabnew<cr>
nnoremap <C-W>gt :sp<cr><C-W>T
nnoremap <C-W><Esc> <Esc>
" Displaying space characters
nnoremap <C-L>n :set listchars=tab:┊\ <cr>
nnoremap <C-L>s :set listchars=tab:\\\|-,eol:$,nbsp:%,space:_,trail:#<cr>
nnoremap <C-L>h :set listchars=<cr>
" Duplicate for input mode
inoremap <C-L>n <esc>:set listchars=tab:┊\ <cr>a
inoremap <C-L>s <esc>:set listchars=tab:\\\|-,eol:$,nbsp:%,space:_,trail:#<cr>a
inoremap <C-L>h <esc>:set listchars=<cr>a
inoremap <C-L><C-L> <C-L>
" Toggle mouse
function! s:togMouse()
	if &mouse == "a"
		set mouse=
	else
		set mouse=a
	endif
endfunction
command! TogMouse call <SID>togMouse()
inoremap <C-L>m <esc>:TogMouse<cr>a
nnoremap <C-L>m :TogMouse<cr>
" Word count
command! Wc w !wc
" New column
function! s:newcol()
	new
	wincmd L
endfunction
command! Newcol call <SID>newcol()
" Force syntax
function! s:forceSyntax(lang)
	unlet! b:current_syntax
	execute "runtime syntax/" . a:lang . ".vim"
endfunction
command! -nargs=1 ForceSyntax call <SID>forceSyntax("<args>")
" Snippets key
let g:snippetsEmu_key = "<A-space>"
" Duplicate line
nnoremap <C-D> mzyyp`zj
inoremap <C-D> <esc>mzyyp`zja
" Duplicate selection
vnoremap <C-D> y`>p
" Find selection
vnoremap // y/\V<C-R>"<CR>
vnoremap /<Right> y/\V<C-R>"
" Same for very magic
vnoremap /v/ y/\v<C-R>"<CR>
vnoremap /v<Right> y/\v<C-R>"
" Atomatic very magic
nnoremap / /\v
" Copy between Vim and X clipboards
nnoremap <A-x>p :let @"=@+<CR>
nnoremap <A-x>y :let @+=@"<CR>
" Replace
nnoremap <A-r> :%s///g<Left><Left><Left>
" Replace selection
vnoremap <A-r> y<esc>:%s/<C-R>"//g<Left><Left>
" Remove tabulation
inoremap <S-Tab> <C-D>
" Make <S-Tab> work in Windows
set t_kB=[Z
" Esc alias
imap <A-;><A-;> <esc>
imap <A-;><A-o> <esc>o
vmap <A-;><A-;> <esc>
vmap <A-;><A-o> <esc>o
" Select word
nnoremap <A-'><A-'> viw
" Clear search highlight
nnoremap <A-'>/ :nohlsearch<CR>
" Select line without <EOL>
onoremap il :<C-U>normal! 0v$h<CR>
vnoremap il 0o$h
" Natural language
set keymap=russian-jcukenwin
lmap \| /
lmap <A-\> \|
set iminsert=0
set imsearch=0
" Color column
set colorcolumn=81
if &t_Co == 8
	hi ColorColumn guibg=DarkGrey ctermbg=Cyan
else
	hi ColorColumn guibg=DarkGrey ctermbg=DarkGrey
endif
" Shortcut for make
nmap <F10> :w \| make<CR>
" Insert current date with seconds
map! <expr> <A-d>s system("date -Iseconds")[:-2]
" Characters
inoremap <C-K><space>  
inoremap <C-K>+- ±
inoremap <C-K>-+ ∓
inoremap <C-K>^ ⊕
inoremap <C-K>&<space> ∩
inoremap <C-K>\|<space> ∪
inoremap <C-K>&& ∧
inoremap <C-K>\|\| ∨
inoremap <C-K>\\ ∖
inoremap <C-K>in ∈
inoremap <C-K>!in ∉
inoremap <C-K>has ∋
inoremap <C-K>!has ∌
inoremap <C-K>each ∀
inoremap <C-K>ex ∃
inoremap <C-K>!ex ∄
inoremap <C-K>dt ∆
inoremap <C-K>sub ⊂
inoremap <C-K>!sub ⊄
inoremap <C-K>ssub ⊊
inoremap <C-K>sup ⊃
inoremap <C-K>!sup ⊅
inoremap <C-K>ssup ⊋
inoremap <C-K>~> ≳
inoremap <C-K>~< ≲
inoremap <C-K>sum ∑
inoremap <C-K>prod ∏
inoremap <C-K>setN ℕ
inoremap <C-K>setZ ℤ
inoremap <C-K>setQ ℚ
inoremap <C-K>setR ℝ
inoremap <C-K>setC ℂ
" Fix collisions with digraphs
inoremap <C-K><C-K> <C-K>
" Disable some keys
nnoremap <A-'> <Nop>
nnoremap <A-x> <Nop>
imap <A-;> <Nop>
vmap <A-;> <Nop>
" C# indentation
au BufNewFile,BufRead,Bufenter *.cs set ts=4 sw=4 et
" Open help about selection in VimScript
au BufNewFile,BufRead,Bufenter *.vim vmap <F1> y:help <C-R>"<CR>
" (La)TeX shortcuts
au BufNewFile,BufRead,Bufenter *.tex vnoremap <A-l>tt <esc>`>a}<esc>`<i\texttt{<esc>
au BufNewFile,BufRead,Bufenter *.tex vnoremap <A-l>bf <esc>`>a}<esc>`<i\textbf{<esc>
au BufNewFile,BufRead,Bufenter *.tex vnoremap <A-l>sl <esc>`>a}<esc>`<i\textsl{<esc>
au BufNewFile,BufRead,Bufenter *.tex vnoremap <A-l>sc <esc>`>a}<esc>`<i\textsc{<esc>
au BufNewFile,BufRead,Bufenter *.tex inoremap <A-l>#<space> \section{}<Left>
au BufNewFile,BufRead,Bufenter *.tex inoremap <A-l>##<space> \subsection{}<Left>
au BufNewFile,BufRead,Bufenter *.tex inoremap <A-l>###<space> \subsubsection{}<Left>
au BufNewFile,BufRead,Bufenter *.tex inoremap <A-l>ul<space> \begin{enumerate}<CR>\end{enumerate}<esc>O
au BufNewFile,BufRead,Bufenter *.tex inoremap <A-l>li<space> \item<space>
" Fix vulnerability
if !has("patch-8.1.1365")
	set nomodeline
endif


set t_Co=256
syntax on
colorscheme minimalist
