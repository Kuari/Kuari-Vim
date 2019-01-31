syntax on
set nu
set t_Co=256
set encoding=utf-8
" :set tabstop=8 expandtab shiftwidth=4 softtabstop=4
" autocmd Syntax go :set tabstop=8 expandtab shiftwidth=8 softtabstop=8
" autocmd Syntax html :set tabstop=8 expandtab shiftwidth=2 softtabstop=2
" 先设置缺省情况，然后根据不同文件类型再次重新设置
set expandtab | set tabstop=4 | set shiftwidth=4  " Python, CSS, etc.
" 对 C/C++ 等，制表符和缩进都是两个空格
au FileType c,cpp,html,htmldjango,lua,javascript,nsis,go
    \ set expandtab | set tabstop=2 | set shiftwidth=2
" Makefile 必须保留制表符，且习惯上占八个空格
au FileType make set noexpandtab | set tabstop=8 | set shiftwidth=8" set pastetoggle=<F8>

let mapleader = ","
let g:mapleader = ","
let g:pymode_python = 'python3'

" set nocompatible
set modeline
filetype plugin on
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
call vundle#end()
filetype plugin indent on

set lazyredraw
" 切换缓存时不用保存
set hidden

" 搜索时忽略大小写，有大写时不忽略
set ignorecase
set smartcase

" 高亮搜索结果并即时显示
set incsearch
set hlsearch
map <silent> <leader><CR> :nohlsearch<CR>

" 替换时缺省启用g
set gdefault

" 缩写显示名字、邮箱和日期时间
iabbrev xname Kuari
iabbrev xmail kuari@justmylife.cc
iabbrev xfile <c-r>=expand("%:t")<CR>
if exists("*strftime")
    iabbrev xdate <c-r>=strftime("%Y-%m-%d")<CR>
    iabbrev xtime <c-r>=strftime("%H:%M:%S")<CR>
endif

" 不用交换文件
set noswapfile

" 检测文件编码时，优先考虑 UTF-8
set fileencodings=utf-8,ucs-bom,gbk,gb2312,big5,latin1

set nowrap

Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
Plugin 'python.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/vim-easy-align'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-surround'
Plugin 'othree/html5.vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-expand-region'
Plugin 'easymotion/vim-easymotion'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'VimIM'
Plugin 'pangloss/vim-javascript'
Plugin 'fatih/vim-go'
Plugin 'kuari/i3window_sw'
Plugin 'posva/vim-vue'
Plugin 'Yggdroot/indentLine'
Plugin 'alvan/vim-closetag'
Plugin 'sheerun/vim-polyglot'
Plugin 'justinmk/vim-syntax-extra'
Plugin 'hail2u/vim-css3-syntax'

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1
"" airline主题
"let g:airline_theme='base16'
let g:airline_theme='biogoo'
"let g:airline_theme='gruvbox'
"let base16colorspace=256
" let g:airline_theme="molokai"
" airline的buffers切换ctrl+b+p/n
nnoremap <C-M> :bn<CR>
nnoremap <C-N> :bp<CR>

" ycm
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_python_binary_path = '/usr/bin/python'

let g:ycm_global_ycm_extra_conf = '~/.vim/data/ycm/.ycm_extra_conf.py'
" 不显示开启vim时检查ycm_extra_conf文件的信息
let g:ycm_confirm_extra_conf=0
" 开启基于tag的补全，可以在这之后添加需要的标签路径
let g:ycm_collect_identifiers_from_tags_files=1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 0
" 输入第2个字符开始补全
let g:ycm_min_num_of_chars_for_completion=2
" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 开启语义补全
let g:ycm_seed_identifiers_with_syntax=1
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
" 引入 C++ 标准库tags
set tags+=/data/misc/software/misc./vim/stdcpp.tags

" colorscheme molokai
colorscheme gruvbox
set bg=dark
au BufEnter * :syntax sync fromstart

" F3 NERDTree 切换
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
" \nt                 打开nerdree窗口，在左侧栏显示
let NERDTreeHighlightCursorline=1
let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
let g:netrw_home='~/bak'
"close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end

" 文件格式
" python的格式
function HeaderPython()
    call setline(1, "#!/usr/bin/python")
    call append(1, "# -*- coding: utf-8 -*-")
    normal G
    normal o
endf
autocmd bufnewfile *.py call HeaderPython()

autocmd bufnewfile *.html 0r ~/.vim/template/simple.html
autocmd bufnewfile *.c 0r ~/.vim/template/simple.c
" autocmd bufnewfile *.md 0r ~/.vim/template/simple.md
" autocmd bufnewfile *.js 0r ~/.vim/template/simple.js

" 直接运行python
map <F5> :!python3 %<CR>

vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
  let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

let g:NERDSpaceDelims = 1

set foldmethod=indent
set foldlevel=99

inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap [[ [<CR>]<Esc>O
inoremap { {}<Esc>i
inoremap { {}<Esc>i
inoremap {{ {<CR>}<Esc>O
" autocmd Syntax html,go,js,vim inoremap } {}<Esc>i
" autocmd Syntax html,go,js,vim inoremap { {<CR>}<Esc>O
" autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

"""自动补全括号
function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 "Inserting a quoted quotation mark into the string
 return a:char
 elseif line[col - 1] == a:char
 "Escaping out of the string
 return "\<Right>"
 else
 "Starting a string
 return a:char.a:char."\<Esc>i"
 endif
endf

"""折叠代码
set foldmethod=indent
au BufWinLeave * silent mkview
au BufRead * silent loadview
nnoremap <space> za
let g:SimpylFold_docstring_preview = 1

" taglist
map <silent> <F4> :TlistToggle<cr>
let Tlist_Use_Right_Window=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Exit_OnlyWindow=1

" 快速插入
execute pathogen#infect()

" 快速跳转
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
    " 设置过滤不进行查找的后缀名
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn|pyc)$'

" 替换esc为jk
inoremap <esc> <esc>l
inoremap jk <esc>l

" 滚屏
inoremap <c-h> <left>
inoremap <c-l> <right>
inoremap <c-j> <down>
inoremap <c-k> <up>

cnoremap <c-h> <left>
cnoremap <c-l> <right>
cnoremap <c-j> <down>

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 系统剪切板
set clipboard=unnamedplus

" 显示空白格
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" 去除尾末空白格
map <silent> <F6> :%s= *$==<cr>

" 区域选中
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

if exists("&indentexpr")
  :set indentexpr=
endif

map <F2> :reg<CR>

" 进入窗口高亮当前行
autocmd WinEnter * set cursorline
" 离开窗口取消高亮
autocmd WinLeave * set nocursorline
" 插入模式取消高亮
autocmd InsertEnter * set nocursorline
" 离开插入模式恢复高亮
autocmd InsertLeave * set cursorline

" easymotion/vim-easymotion 快速移动
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
map <c-\> <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-x>"
let g:UltiSnipsJumpForwardTrigger="<c-c>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" VimIm
let g:Vimim_cloud=-1
let g:vimim_double_pinyin_plusplus=1

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

map <F7> :Separate<CR>
map <F8> :Merge<CR>

" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml'
" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx'
" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1
" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'
" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

au FileType c,cpp,python,vim set textwidth=80
set colorcolumn=81

