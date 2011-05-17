if has("gui_macvim")
  set paste    
  macmenu &File.New\ Tab key=<nop>
  map <D-t> :CommandT<CR>
endif
