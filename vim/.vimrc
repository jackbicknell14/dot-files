" Get off my lawn
noremap  <Left> :echoe "Use h"<CR>
noremap! <Left> <Esc>
noremap  <Down> :echoe "Use j"<CR>
noremap! <Down> <Esc>
noremap  <Up> :echoe "Use k"<CR>
noremap! <Up> <Esc>
noremap  <Right> :echoe "Use l"<CR>
noremap! <Right> <Esc>

set colorcolumn=+1

" Make it obvious where 80 characters is
set textwidth=120

" Numbers
set number
set numberwidth=5

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

set laststatus=2  " Always display the status line
