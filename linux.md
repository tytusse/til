**NOTE**: Commands are for `fish` shell (unless specified otherwise).
# Logout from KDE via command
`qdbus org.kde.Shutdown /Shutdown logout`

# show symlink path
`realpath path/to/symlink`
or for commands in PATH (handy on nixos)
`realpth (which foobarcommand)`
or alternative
`readlink -f symlinkName`

