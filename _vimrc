" VARIABLES

if has('win32') || has ('win64')
        let $VIMHOME = $VIM."/vim73"
    else
        let $VIMHOME = $HOME."/.vim"
endif


" VISUAL OPTIONS

set laststatus=2 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ %{\"[ENC=\".(&fenc==\"\"?&enc:&fenc).\"]\"}\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ %=[FS:%{FileSize()}]\ [LC:%L]
if has("gui_running")
    " no toolbar in GUI mode
    set guioptions=-t 
    set lines=40
    set columns=120
	colorscheme macvim
    if has("win32") || has ('win64')
        set guifont=Consolas:h12
    else
		set background=dark
		set guifont=Menlo:h13
        " start MacVim in fullscreen under OS X
	    au GUIEnter * set fullscreen 
	endif
else
    set term=$TERM                                                  
    set t_Co=256
    colorscheme slate
endif
syntax on
set cursorline
set cursorcolumn
" toggle column & line highlight
map <silent> ,+ :set cursorcolumn!<Bar>set cursorline!<CR>
set number
set numberwidth=4
" used for command line completion
set wildmenu
" always show tabline
set showtabline=2
hi TabLine cterm=none ctermfg=grey ctermbg=black gui=none guifg=#999999 guibg=#1A1A1A
hi TabLineSel cterm=bold,underline ctermfg=black ctermbg=grey gui=bold,underline guifg=#000000 guibg=#D3D3D3
hi TabLineFill ctermfg=black guifg=#1A1A1A
" do not siplay '@' symbols if the last line doesn't fit
set display+=lastline


" EDITING OPTIONS

" change the current working directory according to the opened file
set autochdir
" define indent
set autoindent
set smartindent
set shiftwidth=4
" set indent according to a filetype (let's try to switch it off)
" filetype plugin indent on
" use spaces instead of tabs
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" selecting in INSERT mode
set foldcolumn=0
" set the default folding method
set foldmethod=manual
" add shortcuts to change it
map ,fmm :setlocal foldmethod=manual<CR>
map ,fmi :setlocal foldmethod=indent<CR>
" set the folding method for certain filetypes
autocmd FileType python setlocal foldmethod=indent
autocmd FileType html setlocal foldmethod=indent
autocmd FileType vim setlocal foldmethod=manual
" unfold a file at startup
set foldlevelstart=99
" insert a fold from the cursor to the string
map ,fi zf/
" close a fold
map <silent> ,fc :foldc<CR>
" open a fold
map <silent> ,fo :foldo<CR>
" do not keep a backup file
set nobackup
" but make a backup before overwriting a file
set writebackup
" keep 500 lines of command line history
set history=500
" display incomplete commands
set showcmd
" highlight search results
set hlsearch
" do incremental searching
set incsearch
" ignore case
set ignorecase
" but don't ignore it, when search string contains uppercase letters
set smartcase
" never show DS_Store files
set wildignore+=.DS_Store
" allow switching buffers, which have unsaved changes
set hidden
" ask a confirmation
set confirm
" always set filetype to MARKDOWN
au BufEnter * if &filetype == "" | setlocal ft=mkd | endif
" set filetype to VIM for certain files
au BufRead,BufNewFile *vim* set filetype=vim
" define commenting hotkeys
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>
" set up codepages
if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	set encoding=utf-8
	setglobal fileencoding=utf-8 bomb
	set fileencodings=utf-8,cp1251,koi8-r,latin1
	set fileformats=unix,dos,mac
endif
" set up select in INSERT mode
if has("gui_macvim")
    let macvim_hig_shift_movement = 1
else
	" start selecting text
    imap <C-S-c> <C-o>v
	" paste in INSERT mode
    imap <C-S-v> <C-o><S-p>
	" undo
    imap <C-S-u> <C-o>u
endif


" HOTKEYS AND OTHER CORRESPONDING OPTIONS

map <silent> ,m :set filetype=mkd<CR>
map <silent> ,t :tabedit ~/.config/tasks/tasks<CR> 
map <silent> ,T :tab split<CR>:tabprev<CR>:q<CR>:tabnext<CR>
map e :edit ~/
map ,e :tabedit ~/
map ,S :saveas ~/
map <silent> ,s :w<CR>
map <silent> ,v :tabedit $MYVIMRC<CR>
map <silent> Y y$
map <silent> U :redo<CR>
set pastetoggle=<F7>
map <silent> ,P :hardcopy > %:r.ps<CR>
" use QuickLook in OS X
map <silent> ,p :silent !qlmanage -p %<CR>
" remove empty lines
map <silent> ,del :g/^$/d<CR>
" remove ^M chars
map <silent> ,dem :! sed 's/'"$(printf '\015')"'$//g'<CR>:e<CR>
" replace tabs with spaces
map <silent> ,tab :1, $ s/\t/    /g<CR>
map <silent> ,x :set fileformat=unix<CR>
map <silent> ,d :set fileformat=dos<CR>
" reset last search pattern
map <silent> ,nohl :let @/ = ""<CR>

" Managing tabs
map <silent> <F1> :tabprev<CR>
map <silent> <F2> :tabnext<CR>
map <silent> t :tabnew<CR>

" Managing buffers
map <silent> <F3> :bprev<CR>
map <silent> <F4> :bnext<CR>
map <F5> :buffers<CR>:b<Space>
map <silent> <F8> :bdelete<CR>

" Managinging splits
map <silent> <F6> :vsplit<CR>
map <silent> <M-F6> :split<CR>
map <silent> <S-F6> <C-w>q
" set the minimal height of a window, when it's not the current window
set winminheight=0
set winminwidth=0
" maximize / minimize horizontal splits
map <silent> ,<C-j> <C-w>j<C-w>_
map <silent> ,<C-k> <C-w>k<C-w>_
" maximize / minimize vertical splits
map <silent> <C-j> <C-W>h500<C-W>>
map <silent> <C-k> <C-W>l500<C-W>>
" reset split sizes
map <silent> <C-i> :set noea<CR>:set ea<CR>

" Moving lines
nnoremap <silent> <C-H> :m+<CR>==
nnoremap <silent> <C-L> :m-2<CR>==
inoremap <silent> <C-H> <Esc>:m+<CR>==gi
inoremap <silent> <C-L> <Esc>:m-2<CR>==gi
vnoremap <silent> <C-H> :m'>+<CR>gv=gv
vnoremap <silent> <C-L> :m-2<CR>gv=gv

" Moving through lines
map <silent> <Up> gk
imap <silent> <Up> <C-o>gk
map <silent> <Down> gj
imap <silent> <Down> <C-o>gj
map <silent> <home> g<home>
imap <silent> <home> <C-o>g<home>
map <silent> <End> g<End>
imap <silent> <End> <C-o>g<End>


" HELPERS

" load WRITEROOM-like environment
if has("gui_running")                                           
    if has('win32') || has ('win64')
        map ,w :source $VIMHOME/scripts/writeroom-win.vim<CR>
        map <C-S-f> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    else
        map ,w :source $VIMHOME/scripts/writeroom.vim<CR>
        map <D-0> :set guifont=Menlo:h14<CR>
        map <D-+> :set guifont=Menlo:h16<CR>
    endif
else
    map ,w :source $VIMHOME/scripts/writeroom-ssh.vim<CR>
endif
" load standard VIM environment
map ,W :source $MYVIMRC<CR>
" define FileSize function for the statusline
function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes
    else
        return (bytes / 1024) . "K"
    endif
endfunction
