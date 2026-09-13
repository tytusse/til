**NOTE**: Commands are for `fish` shell (unless specified otherwise).
# Logout from KDE via command
`qdbus org.kde.Shutdown /Shutdown logout`

# show symlink path
`realpath path/to/symlink`
or for commands in PATH (handy on nixos)
`realpth (which foobarcommand)`
or alternative
`readlink -f symlinkName`

# find file by name
- `find -name 'file-pattern'`
- `find -name '*omething*'`

# find file case insensitive
- `find -iname '*OmetHinG*'`

# paths
- `dirname "some/path"`
- `dirname (which "some-file")` - dir for some command
- `dirname (realpath (which some-command))` - if some-command is symlink, then resolve its real path and then show dir path 
- `realpath "somepath/.."` - for when we want relative path
- `realpath "$(dirname (realpath (which some-command)))/.."` - for when we want relative path for something being a result of a command itself
