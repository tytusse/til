[Original fix](https://github.com/kpko)

Notes: 
- for WSL v. `3.0.1.0` with archlinux.
- for single machine (on "other" machine, same update of WSL did not break anything ...)

After `wsl --update` to version `3.0.1.0` executing of windows executables got broken
- at first, it started to use `mono` to run **ALL** win exec and started to fail (obviousely) with:
  > File does not contain a valid CIL image. 
- after removing mono, it startet do fail with
  > The file exists and is executable. Check the interpreter or linker

This is related to `systemd` that hijacs default WSL interop (somehow, IANAL (I am not a linuxmaster)) and solution is to
reintroduce it with magic config as `systemd` "thing".
The solution from link above
- create `/usr/lib/binfmt.d/WSLInterop.conf` file
- make it have content: `:WSLInterop:M::MZ::/init:PF`
- restart WS: (`wsl --shutdown` or `wsl -t <your-distro-name-here>`)

