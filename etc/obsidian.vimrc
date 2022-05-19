set clipboard=unnamed

" esc
imap jk <Esc>

" virtual lines
" nmap j gj
" nmap k gk

unmap <Space>
nmap <Space>/ :nohl

exmap back obcommand app:go-back
nmap <C-o> :back
exmap forward obcommand app:go-forward
nmap <C-i> :forward

