set clipboard=unnamed

" esc
imap jk <Esc>

" virtual lines
nmap j gj
nmap k gk

nmap $ g$
nmap ^ g^

unmap <Space>
nmap <Space>/ :nohl

" exmap back obcommand app:go-back
nmap <C-o> :back
" exmap forward obcommand app:go-forward
nmap <C-i> :forward

exmap wiki surround [[ ]]
map [[ :wiki

exmap code surround ` `
map gs` :code

exmap wi surround https://gus.my.salesforce.com/apex/ADM_WorkLocator?bugorworknumber= #
map gsw :wi

