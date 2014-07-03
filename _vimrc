" DESCRIPTION: Vim config file
" AUTHOR: dsjkvf@gmail.com
" NOTE: Please, use it at your own risk


" VARIABLES

" Set $VIMHOME
if has('win32') || has ('win64')
        let $VIMHOME = $VIM."/vim73"
    else
        let $VIMHOME = $HOME."/.vim"
endif


" VISUAL OPTIONS

" Fonts, toolbars, colorschemes
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
		set guifont=Menlo:h15
        " start MacVim in fullscreen under OS X
	    autocmd GUIEnter * set fullscreen 
	endif
else
    set term=$TERM                                                  
    set t_Co=256
    colorscheme slate
endif
syntax on

" Crosshair
" set cursorline
" set cursorcolumn
" toggle column & line highlight
map <silent> ,+ :set cursorcolumn!<Bar>set cursorline!<CR>

" Menus
" used for command line completion
set wildmenu
" display commands
set showcmd
" ask a confirmation
set confirm

" Statusline
set laststatus=2 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ %{\"[ENC=\".(&fenc==\"\"?&enc:&fenc).\"]\"}\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ %=[FS:%{FileSize()}]\ [LC:%L]

" Numberline
set number
set numberwidth=4

" Tabline
" always show tabline
set showtabline=2
hi TabLine cterm=none ctermfg=grey ctermbg=black gui=none guifg=#999999 guibg=#1A1A1A
hi TabLineSel cterm=bold,underline ctermfg=black ctermbg=grey gui=bold,underline guifg=#000000 guibg=#D3D3D3
hi TabLineFill ctermfg=black guifg=#1A1A1A

" Scrolling
" keep at least 5 lines above/below
set scrolloff=5 
" keep at least 5 lines left/right
set sidescrolloff=5 
" do not siplay '@' symbols if the last line doesn't fit
set display+=lastline
" no error bells
set vb t_vb=

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


" EDITING OPTIONS

" Files and directories
" change the current working directory according to the opened file
set autochdir
" do not keep a backup file
set nobackup
" but make a backup before overwriting a file
set writebackup
" never show DS_Store files
set wildignore+=.DS_Store

" History
" keep 500 lines of command line history
set history=500
" highlight search results
" Search
set hlsearch
" do incremental searching
set incsearch
" ignore case
set ignorecase
" but don't ignore it, when search string contains uppercase letters
set smartcase
" show matching parenthesis
set showmatch

" Selecting
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

" Indenting
set autoindent
set copyindent
set smartindent
set shiftwidth=4
set shiftround
" set indent according to a filetype (let's try to switch it off)
" filetype plugin indent on
filetype plugin on
" use spaces instead of tabs
set expandtab
set smarttab
set tabstop=4
set softtabstop=4
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Folding
" set the width for foldcolumn
set foldcolumn=3
" setthe maximum level for folds
set foldnestmax=2
" set the default folding method
set foldmethod=manual
" add shortcuts to change it
map ,fmm :setlocal foldmethod=manual<CR>
map ,fmi :setlocal foldmethod=indent<CR>
" set the folding method for certain filetypes
autocmd FileType python setlocal foldmethod=expr
autocmd FileType html setlocal foldmethod=indent
autocmd FileType vim setlocal foldmethod=expr
" unfold a file at startup
set foldlevelstart=1
" insert a fold from the cursor to the string
map ,fi zf/
" close a fold
map <silent> ,fc :foldc<CR>
" close all folds
map ,fA zM
" open a fold
map <silent> ,fo :foldo<CR>
" open all folds
map ,fa zR
" define fold related colors
if has("gui_running")
	highlight FoldColumn guibg=black guifg=red
    highlight Folded guibg=grey guifg=white
else
    highlight FoldColumn ctermbg=none ctermfg=red
    highlight Folded ctermbg=grey ctermfg=white
endif

" Commenting
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Codepages
if has("multi_byte")
	if &termencoding == ""
		let &termencoding = &encoding
	endif
	set encoding=utf-8
	setglobal fileencoding=utf-8 bomb
	set fileencodings=utf-8,cp1251,koi8-r,latin1
	set fileformats=unix,dos,mac
endif


" HOTKEYS AND OTHER CORRESPONDING OPTIONS

" Handies
imap ii <C-[>
nnoremap ; :
" navigating
nnoremap <Space> <C-d>
nnoremap <S-Space> <C-u>
nnoremap c <C-u>
nnoremap B <Home>
nnoremap E <End>
" open
map ,e :edit ~/
map ,t :tabedit ~/
" save
map ,S :saveas ~/
map <silent> ,s :w<CR>
imap <silent> ,s <ESC>:w<CR>
" reload if chnages are made to config files
augroup myvimrc
    autocmd!
    autocmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC
augroup END
map <silent> ,v :tabedit $MYVIMRC<CR>
map <silent> Y y$
map <silent> U :redo<CR>
set pastetoggle=<F7>
" preview in QuickLook on OS X
map <silent> ,p :silent !qlmanage -p %<CR>
" print to PostScript
map <silent> ,P :hardcopy > %:r.ps<CR>
" remove empty lines
map <silent> ,del :g/^$/d<CR>
" remove ^M chars
map <silent> ,dem :! sed 's/'"$(printf '\015')"'$//g'<CR>:e<CR>
map <silent> ,x :set fileformat=unix<CR>
map <silent> ,d :set fileformat=os<CR>
" remove leading spaces
map ,des :.,$s/^ *//<CR>
" replace tabs with spaces
map <silent> ,tab :1, $ s/\t/    /g<CR>
" reset last search pattern
map <silent> ,/ :let @/ = ""<CR>
" or do it that way
map <silent> ,nohl :nohlsearch<CR>

" Managing tabs
map <silent> <F1> :tabprev<CR>
map <silent> <F2> :tabnext<CR>
map <silent> t :tabnew<CR>

" Managing buffers
map <silent> <F3> :bprev<CR>
map <silent> <F4> :bnext<CR>
map <F5> :buffers<CR>:b<Space>
map <silent> <F8> :bdelete<CR>
" allow switching buffers, which have unsaved changes
set hidden
" always set new buffer's filetype to MARKDOWN
" autocmd BufEnter * if &filetype == "" | setlocal ft=mkd | endif
" set filetype to VIM for certain files
autocmd BufRead,BufNewFile *vim* set filetype=vim

" Managing splits
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
" move active split to a new tab
map <silent> ,T :tab split<CR>:tabprev<CR>:q<CR>:tabnext<CR>

" Managing filetypes
map <silent> ,m :set filetype=mkd<CR>
autocmd FileType python inoremap .. <End>:

" Managing plugins
" simple-bookmarks
map ,bb :Bookmark 
map ,bd :DelBookmark 
map ,bg :GotoBookmark 
map <silent> ,bl :CopenBookmarks<CR>
" simple-note
map <silent> ,ll :Simplenote -l<CR>
map ,lt :Simplenote -l 
map <silent> ,ld :Simplenote -d<CR>
map ,lg :Simplenote -t<CR>


" HELPERS

" Load WRITEROOM-like environment
if has("gui_running")                                           
    if has('win32') || has ('win64')
        map <silent> ,w :source $VIMHOME/scripts/writeroom-win.vim<CR>
        map <C-S-f> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    else
        map <silent> ,w :source $VIMHOME/scripts/writeroom.vim<CR>
        map <D-0> :set guifont=Menlo:h14<CR>
        map <D-+> :set guifont=Menlo:h16<CR>
    endif
else
    map <silent> ,w :source $VIMHOME/scripts/writeroom-ssh.vim<CR>
endif

" Load standard VIM environment
map <silent> ,W :source $MYVIMRC<CR>

" Define FileSize function for the statusline
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
