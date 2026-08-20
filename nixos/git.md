To use oauth/browser with git/jj

# credential manager
## succeeded attempt, pure nix
Credits/source: https://discourse.nixos.org/t/git-credential-manager-on-nixos/25742/7

NOTE: that 
- this is for vanilla nixos style aka `configuration.nix`
- `git` is installed via `programs.git` not via `systemPackages`
- `git-credential-manager` is installed explicitly via `systemPackages`

```nix
  programs.git = {
    enable = true;
    config = {
      credential = {
        helper = "manager";
        credentialStore = "secretservice";
      };
    };
  };

  # (.....)

  environment.systemPackages = with pkgs; [
    # (...)
    # git - see programs.git
    git-credential-manager
  ]
```

This is not the 1st time when nix works better than "hacking".
On the other hand, hacking is needed on nixos more when not using nix, i.e. because paths to libs (`*.so`) are not trivial (nix store).


## FAILED attempt via dotnet tool
Requires dotnet 10 at time of writing 

Installed using instructions: https://github.com/git-ecosystem/git-credential-manager/blob/release/docs/install.md#net-tool

```bash
dotnet tool install -g git-credential-manager
git-credential-manager configure
```

I used global dotnet package as it also requires ENV vars which I could not figure out how to set "user only" via nix.
(via bashrc/fish ok, but vars require path to dotnet package, perhaps I could just `realpath (which dotnet)` and use it?
Because it is a symlink.

Meanwhile, in `configuration.nix`:
```nix
  environment.systemPackages = with pkgs; [
    # skipped rest...
    dotnet-sdk_10
  ];


  environment.sessionVariables = {
    # skipped others...
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet/";
  };

```
