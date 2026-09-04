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

# open new empty: buffer, tab, window
- `:enew` - "Edit a new, unnamed buffer"
  - with NvChad, adds buffer and "tab"
- `:tabnew` - new empty tab, with "vanilla" adds "tab", with NvChad it is harder to explain - it adds a sort of group of tabs with indicator in top-right corner
  - I *think* that vim tabs are exactly like that - groups of buffers;
- `:vnew` / `:new` - new empty window at bottom (new) / right (vnew)

# closing tabs, buffers windows
- `:bd` closes buffer
- `:q` closes current window - **if it is the only window, then whole app closes**
- `:qa` closes all windows and hecne the whole app
- `:tabc` close tab page

# file explore - classic nvim/vim - `:Explore`
- `:Sex` (yes you reading correctly) - this means `:Explore` in horizontal split (shorthand for `:Sexplore`)
- OG command is `:Explore` (or `Ex`) which opens file explorer in current window,
  also can use `:Vexplore` or `:Vex` for vertical split.

# syntax highlighting (for nvchad/lazy/treesitter)
NVChad uses treesitter. "What worked" should be ok for any other setup with treesitter installed.

## What worked
Issue `:TSInstall <your_language>` command, i.e. `:TSInstall fsharp` installs fsharp support.

## What DID NOT work
Config is in `~/.config/nvim/lua/plugins/init.lua`, look for "nvim-treesitter/nvim-treesitter".
Add lang you want to `opts.ensure_installed` list, take name from here: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md.

i.e.,

```lua
{
-- other plugins here (skipped)
  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = { "vim", "lua", "vimdoc", "html", "css", "c_sharp" },
-- (... skipped part ...)
  }
}
```

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
