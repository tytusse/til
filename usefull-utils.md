List of usefull cmdline apps (some obvious some less obvious):
https://www.linuxlinks.com/100-great-must-have-cli-linux-applications/

My favourites (includes ones not on list under link) 
(will likely just make `*.nix` out of them)
- git
- bat
- jujutsu
- neovim
- fish
- zoxide (https://github.com/ajeetdsouza/zoxide)
    alternative to cd, needs setup and may require `fzf`
- tldr - display cli examples (alt to manpages)

To consider
- rclone (i.e., to sync keepass)
- Keepass HC
- ripgrep (better grep)
- `go-yq` (yaml query and modifications): https://github.com/mikefarah/yq
  - https://www.baeldung.com/linux/yq-utility-processing-yaml

Interesting ones
- localtunnel - share pservice over temporary public DN
- gotty - share terminal in browser
- mitmproxy - tracing network traffic
- howdoi: 
  > howdoi offers instant coding answers via the command line
  > `$ howdoi print hello in Rust`
- `yank` - "yank reads input from stdin and display a selection interface that
  allows a field to be selected and copied to the clipboard."
- `watson` - time tracker
- `entr` is a tool for running arbitrary commands when files change. 
  It was written to make rapid feedback and automated testing natural and
  completely ordinary.
- `jq` is like sed for JSON data – you can use it to slice and filter and map 
  and transform structured data with the same ease that sed, awk, grep and 
  friends let you play with text.
- `progress` is a neat tool to show progress for cp, mv, dd, … 
  (formerly known as cv).
- `s` is a web search utility which runs from the terminal. Just opens in 
  your browser
- `difftastic` is a structural diff tool that compares files based on their 
  syntax 
