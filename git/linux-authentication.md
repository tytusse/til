# to have nice OAuth login via https - use GCM tool
**Requires dotnet 10 at time of writing**

Installed using instructions: https://github.com/git-ecosystem/git-credential-manager/blob/main/docs/install.md#net-tool

```bash
dotnet tool install -g git-credential-manager
git-credential-manager configure
```
## WSL / Windows
- One can either use windows via `/mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe` or linux via vanilla `dotnet tool` as above.
- The `/mpt/...` one requires installation of git on windows, but has advantage of using windows secrets store (if one counts it as advantage).

Personally, I prefer Linux one.

- May need to remove old `credential.helper` from `git config edit --global` (note that the empty entry is OK!!!)
  ```ini
  [credential]
    credentialStore = secretservice
  ; REMOVE/comment: helper = /mnt/c/Program\\ Files/Git/mingw64/bin/git-credential-manager.exe
	  helper = 
	  helper = /home/yourusername/.dotnet/tools/git-credential-manager
  ```
- if `credentialStore = secretservice`, then requires to have store, i.e. `gnome-keyring`. Will pop-up with password prompt on occasions.
- May need to restart WSL
  ```powershell
  wsl --shutdown 
  ```
