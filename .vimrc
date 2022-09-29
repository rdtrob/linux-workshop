" We use this check because Some distributions come by default with vim-tiny,
"  a stripped down version of VIm.
if has("eval")
  let skip_defaults_vim = 1

" automatically indent new lines
set autoindent

" automatically write files when changing between files - Autosave
set autowrite

" turn col and row positions on in bottom right section
set ruler

" show command and insert mode
set showmode

" set tab value
set tabstop=2

set smartindent

set textwidth=72

" disable relative line numbers, comment to sample it
set norelativenumber

" highlight search hits
set hlsearch
set incsearch
set linebreak

" stop complaints about switching buffers with unsaved changes
set hidden

" set command history
set history=1000

" enable faster scrolling
set ttyfast

" allows Vim to sense filetype
set filetype plugin on

set background=dark


" > NOTE: Like in bash scripts, we can write logic into the
"          .vimrc and vimscript in general
if v:version >= 800
  " stop vim from silently messing with files that it shouldn't mess with
  set nofixedofline
endif
