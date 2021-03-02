" 插件定义开始
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'joshdick/onedark.vim'
Plug 'Yggdroot/indentLine'
Plug 'godlygeek/tabular'
Plug 'hrp/EnhancedCommentify'
Plug 'tpope/vim-surround'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/gv.vim'
Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'

"Plug 'dense-analysis/ale'
Plug 'rhysd/vim-clang-format'

Plug 'ludovicchabant/vim-gutentags'
" 插件到此结束
call plug#end()

"indentLine
let g:indentLine_noConcealCursor = 1
let g:indentLine_color_term = 239
let g:indentLine_char = '┆'
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 4 " (default: 2)
let g:EnhCommentifyRespectIndent = 'Yes'
let g:EnhCommentifyPretty = 'Yes'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

filetype indent on

" C/C++ 自动补全插件
set nocp
filetype plugin on
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_ShowPrototypeInAbbr = 1

"为python和shell等添加注释
autocmd FileType python,shell,coffee set commentstring=#\ %s
"修改注释风格
autocmd FileType java,c,cpp set commentstring=//\ %s

"文件树
nmap <C-n> :NERDTreeToggle<CR>

"字符操作
set noeb

set et
set ci
set shiftwidth=4
set list listchars=tab:»\ ,trail:.,extends:»,precedes:«
set nolist

autocmd FileType make setlocal noexpandtab

" 设置 mapleader，后面键盘映射随时要用
" 基本上所有自定义的快捷键都以这个字符打头，比如映射`,w`为`:w`
let mapleader = "`"
let g:mapleader = "`"

" 不兼容 Vi，最大限度使用新特性
set nocompatible

" 写入文件时，不做备份
set nobackup
set nowritebackup

" 不用交换文件
set noswapfile

" 保存文件的快捷键
nmap <leader>w :w!<CR>

"设置tag
set tag=tags;/
syn on se title

" 移除 Windows 文件结尾的 `^M`
noremap <leader>m :%s/<C-V><C-M>//ge<CR>

" 重新打开文件时，恢复上一次游标位置
" 通过View可以记住很多设置，比如高亮当前行、折行等等，但是往往比较让人费解
set viewoptions=cursor  " 只记住游标
au BufWinLeave ?* mkview
au VimEnter ?* silent loadview

" 检测文件编码时，优先考虑 UTF-8
set fileencodings=utf-8,ucs-bom,gbk,gb2312,big5,latin1

" 不同平台，设置不同的行尾符，即 EOL
" 注意：在 Mac 平台，也是 unix 优先；自 OS X 始，行尾符与 Unix 一致，
"      都是 `\n` 而不是 `\r`
if has("win32")
    set fileformats=dos,unix,mac
else
    set fileformats=unix,mac,dos
endif

" 在断行、合并(join)行时，针对多字节字符（比如中文）的优化处理
set formatoptions+=mM

" 采用 C 风格的缩进，适用于大多数语言
" 细节调整见下面的 `cinoptions`
" 可以尝试 smartindent 和 autoindent
set cindent
set background=dark
set ignorecase                              "忽略大小写"
syntax enable
colorscheme gruvbox
" 背景透明
"highlight Normal guibg=NONE ctermbg=None

au BufEnter * :syntax sync fromstart

" 细节调整，主要为了适应 Google C++ Style
" t0: 函数返回类型声明不缩进
" g0: C++ "public:" 等声明缩进一个字符
" h1: C++ "public:" 等声明后面的语句缩进一个字符
" N-s: C++ namespace 里不缩进
" j1: 合理的缩进 Java 或 C++ 的匿名函数，应该也适用于 JS
set cinoptions=t0,g1,h1,N-s,j1

" smart table
set smarttab

" 先设置缺省情况，然后根据不同文件类型再次重新设置
set expandtab | set tabstop=4 | set shiftwidth=4  " Python, CSS, etc.

" 制表符和缩进都是8个空格
au FileType html,htmldjango,lua,javascript,nsis
    \ set expandtab | set tabstop=8 | set shiftwidth=8

" 单独设置C/C++的缩进,C/C++保留table
au FileType c,cpp set noexpandtab |set tabstop=8 |set shiftwidth=8

" Makefile 必须保留制表符，且习惯上占八个空格
" 不过，这年头谁还会写 Makefile？
au FileType make set noexpandtab | set tabstop=8 | set shiftwidth=8

" 限制长度84字符
au FileType c,cpp,python,vim set textwidth=84

" 限长分割线
"set colorcolumn=80

au FileType text,markdown,html,xml set wrap

" 折行时，以单词为界，以免切断单词
set linebreak

" 折行后的后续行，使用与第一行相同的缩进
set breakindent

" 即使在终端，也尽量启用鼠标
if has("mouse") | set mouse=a | endif

" 显示输入中的命令，对 gqq/gcc 这种多个字符的命令特别有用
set showcmd

" 下面几个不解释，自行查看帮助
set scrolloff=7
set wildmenu
set wildmode="list:longest"
set ruler

" 命令行高度为1行
set cmdheight=1

" 永远显示行号
" 另有比较酷的相对行号（`relativenumber`），虽然我用不习惯
set number
"set relativenumber

" 切换缓存时不用保存
set lazyredraw

" 输入模式下，退格键可以退一切字符
set hidden
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" 高亮当前行
"set cursorline

" 忽略大小写
set ignorecase
set smartcase

"即时显示匹配结果
set incsearch

"高亮所有结果
set hlsearch

map <silent> <leader><CR> :nohlsearch<CR>
set gdefault

iabbrev xname carson
iabbrev xmail 1262903432@qq.com
iabbrev xfile <c-r>=expand("%:t")<CR>
if exists("*strftime")
    iabbrev xdate <c-r>=strftime("%Y-%m-%d")<CR>
    iabbrev xtime <c-r>=strftime("%H:%M:%S")<CR>
endif

"# 这个函数通过替换命令删除行尾空格
func! DeleteTrailingWS()
    exec "normal mz"
    %s/\s\+$//ge
    exec "normal `z"
endfunc

" 保存时自动删除行尾空格
au BufWrite * :call DeleteTrailingWS()
map <leader>W :call DeleteTrailingWS()<CR>

" 移除只包含空格的行里的空格（有点绕口）
" 貌似有了前面的函数，这个就没有什么必要了
map <F3> :%s/\s*$//g<CR>:noh<CR>''<CR>

" 自动生成文件头
autocmd BufNewFile *.py,*.[ch],*.hpp,*.cpp,Makefile,*.mk,*.sh exec ":call SetTitle()"

func SetTitle()

    if expand("%:e") == 'c'
        call setline(1, "#include \"".expand("%:t:r").".h\"")
        call setline(2, "")
        call setline(3, "// vim: ts=8 sw=8 noet autoindent:")
    endif

    if expand("%:e")=='h'
        call setline(1, "#ifndef __".toupper(expand("%:t:r"))."_H__")
        call setline(2, "#define __".toupper(expand("%:t:r"))."_H__")
        call setline(3,"")
        call setline(4,"")
        call setline(5,"")
        call setline(6, "#endif /*__".toupper(expand("%:t:r"))."_H__ */")
        call setline(7, "// vim: ts=8 sw=8 noet autoindent:")
    endif
d
    if expand("%:e")== 'py'
        call setline(1, "#!/usr/bin/env python3")
        call setline(2, "# -*- coding: utf-8 -*-")
        call setline(3, "")
        call setline(4, "# vim: ts=4 sw=4 noet autoindent:")
    endif

endfunc

" ctag 插件
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']


