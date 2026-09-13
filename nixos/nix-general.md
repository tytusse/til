# resolve package root dir by associated command name 
For example, if we have path-visible command named `some-command`, then

```fish
realpath "$(dirname (realpath (which some-command)))/.."
```

This assumes that "some-command" is inside "bin" subdir in nix store package path, i.e.
`realpath (which g++)` --> `/nix/store/06i01ld530x5pnhy1wmz5rbs8491s9x8-gcc-15.2.0/bin/g++`

The long magic command is then
- `which somne-command`: resolve full path to command.
  
  This will resolve to user profile path of the **symlink**: `/etc/profiles/per-user/tomek/bin/some-command`

- `realpath (which some-command))`: resolve symlink (nix creates symlinks in user profile to point to nix store path)

  This will go to nix store path, i.e. `/nix/store/06i01ld530x5pnhy1wmz5rbs8491s9x8-gcc-15.2.0/bin/g++`
- `dirname(realpath (which some-command)))` - parent dir of real path - most likely "bin" subdir of nix store path of package
- finally: `realpath "$(dirname (realpath (which some-command)))/.."` - takes "bin" path, goes one up, resolves to absolute path.

  We get nix store path, i.e. for `g++` it will be `/nix/store/06i01ld530x5pnhy1wmz5rbs8491s9x8-gcc-15.2.0`


There are likely better ways to do it.
