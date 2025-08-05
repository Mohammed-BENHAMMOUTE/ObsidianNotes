" .obsidian.vimrc - Optimized for Obsidian Vim plugin
" This configuration focuses on text editing, navigation, and Obsidian-specific workflows

" ============================================================================
" BASIC VIM SETTINGS
" ============================================================================

" Essential settings
set scrolloff=5
set incsearch
set ignorecase
set smartcase
set hlsearch
set relativenumber
set number
set showcmd
set clipboard=unnamed

" Better editing behavior  
set timeoutlen=500
set virtualedit=block

" Leader key
let mapleader = " "

" ============================================================================
" MOVEMENT AND NAVIGATION
" ============================================================================

" Easier line navigation - no more $ and 0!
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

" Better j/k movement (visual lines, not logical lines)
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Quick word navigation
nnoremap W 5w
nnoremap B 5b
nnoremap E 5e

" Center screen on jumps
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap G Gzz
nnoremap gg ggzz

" Quick jumps
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Paragraph navigation
nnoremap { {zz
nnoremap } }zz

" ============================================================================
" TEXT EDITING AND MANIPULATION
" ============================================================================

" Smart Home/End behavior
nnoremap <Home> ^
inoremap <Home> <C-o>^
nnoremap <End> $
inoremap <End> <C-o>$

" Better line operations
nnoremap Y y$
nnoremap D d$
nnoremap C c$

" Quick line operations
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

" Duplicate line/selection
nnoremap <leader>d yyp
vnoremap <leader>d y'>p

" Join lines intelligently
nnoremap J :join<CR>
nnoremap gJ J

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Better indentation
vnoremap < <gv
vnoremap > >gv
nnoremap <leader>< <<
nnoremap <leader>> >>

" ============================================================================
" SELECTION AND CLIPBOARD
" ============================================================================

" Select all
nnoremap <leader>a ggVG

" Better paste behavior
vnoremap p "_dP
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>y "+y
nnoremap <leader>y "+y

" Quick text selection
nnoremap <leader>vw viw
nnoremap <leader>vp vip
nnoremap <leader>vs vis
nnoremap <leader>vt vit

" Select inner/around common objects
nnoremap <leader>iw viw
nnoremap <leader>ip vip
nnoremap <leader>ib vib
nnoremap <leader>iB viB
nnoremap <leader>i" vi"
nnoremap <leader>i' vi'
nnoremap <leader>i` vi`

" ============================================================================
" SEARCH AND REPLACE
" ============================================================================

" Clear search highlighting
nnoremap <Esc> :nohlsearch<CR>
nnoremap <leader>/ :nohlsearch<CR>

" Quick search for word under cursor
nnoremap <leader>* *N
nnoremap <leader># #N

" Quick find and replace
nnoremap <leader>s :%s/
vnoremap <leader>s :s/
nnoremap <leader>sw :%s/\<<C-r><C-w>\>/

" ============================================================================
" OBSIDIAN-SPECIFIC MAPPINGS
" ============================================================================

" Note navigation and creation
nnoremap <leader>n :ObsidianNew<CR>
nnoremap <leader>nn :ObsidianQuickSwitch<CR>
nnoremap <leader>nf :ObsidianSearch<CR>
nnoremap <leader>nt :ObsidianTags<CR>

" Links and references  
nnoremap <leader>ll :ObsidianLink<CR>
nnoremap <leader>lf :ObsidianFollowLink<CR>
nnoremap <leader>lb :ObsidianBackLinks<CR>
nnoremap <leader>lt :ObsidianTemplate<CR>

" Daily notes
nnoremap <leader>nd :ObsidianToday<CR>
nnoremap <leader>ny :ObsidianYesterday<CR>
nnoremap <leader>nm :ObsidianTomorrow<CR>

" Workspace and view
nnoremap <leader>nw :ObsidianWorkspace<CR>
nnoremap <leader>nr :ObsidianRename<CR>

" ============================================================================
" MARKDOWN SHORTCUTS
" ============================================================================

" Quick markdown formatting
nnoremap <leader>mb I- [ ] <Esc>
nnoremap <leader>mt I- <Esc>
nnoremap <leader>m1 I# <Esc>
nnoremap <leader>m2 I## <Esc>
nnoremap <leader>m3 I### <Esc>
nnoremap <leader>m4 I#### <Esc>

" Emphasis
vnoremap <leader>mb c**<C-r>"**<Esc>
vnoremap <leader>mi c*<C-r>"*<Esc>
vnoremap <leader>mc c`<C-r>"`<Esc>
vnoremap <leader>ms c~~<C-r>"~~<Esc>

" Links
vnoremap <leader>ml c[<C-r>"]()<Esc>hi

" ============================================================================
" QUICK EDITING SHORTCUTS
" ============================================================================

" Fast escape alternatives
inoremap jj <Esc>
inoremap jk <Esc>
inoremap kj <Esc>

" Quick save (if supported)
nnoremap <leader>w :w<CR>

" Quick pairs
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

" Delete pairs when backspacing
inoremap <BS> <C-r>=<SID>SmartBackspace()<CR>

function! s:SmartBackspace()
    let col = col('.') - 1
    let line = getline('.')
    let prev_char = col > 0 ? line[col-1] : ''
    let next_char = col < len(line) ? line[col] : ''
    
    if (prev_char == '"' && next_char == '"') ||
     \ (prev_char == "'" && next_char == "'") ||
     \ (prev_char == '`' && next_char == '`') ||
     \ (prev_char == '(' && next_char == ')') ||
     \ (prev_char == '[' && next_char == ']') ||
     \ (prev_char == '{' && next_char == '}')
        return "\<Del>\<BS>"
    else
        return "\<BS>"
    endif
endfunction

" ============================================================================
" TEXT OBJECTS AND MOTIONS
" ============================================================================

" Better word motions
nnoremap <leader>w daw
nnoremap <leader>W daW
nnoremap <leader>cw ciw
nnoremap <leader>cW ciW

" Sentence and paragraph operations
nnoremap <leader>cs cis
nnoremap <leader>cp cip
nnoremap <leader>ds dis
nnoremap <leader>dp dip

" Quick punctuation jumps
nnoremap <leader>; f;
nnoremap <leader>, f,
nnoremap <leader>. f.
nnoremap <leader>: f:

" ============================================================================
" MACROS AND REPETITION
" ============================================================================

" Quick macro replay
nnoremap Q @@
nnoremap <leader>q @q

" Repeat last command
nnoremap <leader>. .

" ============================================================================
" CASE CONVERSION
" ============================================================================

" Word case changes
nnoremap <leader>U gUiw
nnoremap <leader>u guiw
nnoremap <leader>~ g~iw

" Line case changes
nnoremap <leader>uL gUU
nnoremap <leader>ul guu

" ============================================================================
" FOLDING (if supported)
" ============================================================================

nnoremap <leader>zo zo
nnoremap <leader>zc zc
nnoremap <leader>za za
nnoremap <leader>zr zR
nnoremap <leader>zm zM

" ============================================================================
" PRODUCTIVITY SHORTCUTS
" ============================================================================

" Insert current date
nnoremap <leader>td "=strftime('%Y-%m-%d')<CR>P
inoremap <C-d> <C-r>=strftime('%Y-%m-%d')<CR>

" Insert current time
nnoremap <leader>tt "=strftime('%H:%M')<CR>P
inoremap <C-t> <C-r>=strftime('%H:%M')<CR>

" Increment/decrement numbers
nnoremap + <C-a>
nnoremap _ <C-x>

" Quick substitution for word under cursor
nnoremap <leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" Toggle between last two files (if supported)
nnoremap <leader><leader> <C-^>

" ============================================================================
" VISUAL MODE ENHANCEMENTS
" ============================================================================

" Stay in visual mode after indenting
xnoremap < <gv
xnoremap > >gv

" Move visual selection
xnoremap <A-j> :move '>+1<CR>gv-gv
xnoremap <A-k> :move '<-2<CR>gv-gv

" ============================================================================
" COMMAND LINE SHORTCUTS
" ============================================================================

" Command line navigation
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>

" ============================================================================
" TIPS AND REMINDERS
" ============================================================================

" Quick reference for new shortcuts:
" H/L - Start/End of line (instead of ^/$)
" <leader>d - Duplicate line
" <leader>o/O - Insert blank line below/above
" <leader>n* - Obsidian note commands
" <leader>l* - Link commands
" <leader>m* - Markdown formatting
" jj/jk/kj - Quick escape from insert mode
" W/B/E - Jump 5 words forward/back/end
" +/- - Increment/decrement numbers
" Alt+j/k - Move lines up/down
" <leader>r - Quick substitute word under cursor
