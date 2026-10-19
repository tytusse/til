After recent channel update, the nvidia open drivers stopped building.
Some C error linked to compiler version/kernel version change.
Final solution was to manually select newer driver (likely to be reverted when next channel update occurs).
Link to solution (github issue discussion): https://github.com/NixOS/nixpkgs/issues/554125#issuecomment-5346123812 

# Copilot + Nixos
I tried Copilot the thing but it was very inefficient and failed.
In fact, it tried to build a patch for `*.c` file and apply it on the fly using `sed`.
Idea is not that bad if one has no choice, problem is that it could not guess how to apply that patch.
Part of the problem is likely nixos being very steep curve for anyone/anything.
