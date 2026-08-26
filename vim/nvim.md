# write command output to buffer
`:enew|pu=execute('map')`

From: https://tech.serhatteker.com/post/2022-07/dump-command-output-to-buffer-in-neovim/

# print current file path
`:echo expand('%:p')`

# print current file parent folder
`:echo expand('%:p:h')`

# readonly
- https://neovim.io/doc/user/starting/#-R
- `nvim -R <filename>`
- to allow edit but prevent save: inside vim/nvim: `:set readonly` (https://neovim.io/doc/user/options/#'readonly')
- to not allow edit: `set noma` 
    - https://neovim.io/doc/user/options/#'modifiable'
    - option is `modifiable`, short: `ma`, in vim `set no<option_name>` sets toggle optiob to `false/off,`
      hence `set noma` => "set modifiable to off"

# tutorials
- https://builtin.com/software-engineering-perspectives/neovim-configuration
- https://www.baeldung.com/linux/vim-neovim-configs
- https://neovim.io/doc/user/

# General tips
- neovim config is in `~/.config/nvim/init.lua`
- neovim can reuse vim config via `source ~/.vimrc`; probably a good idea
  when using InteliJVim plugin which also can use VIM cfg.
- first thing `init.lua` does is `vim.cmd('source ~/.vimrc')`
- ~~need to separate nvim specific from vim (*TODO*)~~ - abandoned, the 
  key idea was to have ideavim + nvim, but this is form over substance
- there is a lua based setup somewhere on the internet, which makes this
  little program behave almost like an IDE
- nvim has built-in tutorial - `:help Tutor<CR>`
- for surrounding text: `vim-surround`:
  https://www.vim.org/scripts/script.php?script_id=1697
- exiting to normal mode after timeout: `:autocmd CursorHoldI * stopinsert`

# NvChad:
- https://nvchad.com/docs/quickstart/install
- Nerd Font: https://www.nerdfonts.com/
  - i.e. JetBrainsMono NerdFont (!needs to be NerdVont not regular JB font) 
  - WSL: 
    - install font in Windows (in control pannel/settings, drag and drop `*.ttf`)
    - configure font in terminal app
  - Linux (not tested)
    - Install fonts: https://gist.github.com/rajeshkumaravel/2795c341f4adf9daffb1791dd5bd3004
      (use `/usr/local/share/fonts`)
    - most likely, also need to set it up in terminal app.
- `tree-sitter-cli` - `yay tree-sitter-cli`
- `ripgrep` - `yay ripgrep` 
- then 
   - remove `.config/nvim` (can backup first, whatever)
   - git clone https://github.com/NvChad/starter ~/.config/nvim && nvim
   - remove `.config/nvim/.git` afterwards

# IdeaVim
See [here](ideavim.md)
