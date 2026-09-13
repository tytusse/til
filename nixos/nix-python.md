# to install specific version in configuration.nix with pre-installed packages

https://nixos.org/manual/nixpkgs/stable/#environment-defined-in-etcnixosconfiguration.nix

Snippet from link

```nix
{
  # ...

  environment.systemPackages = with pkgs; [
    (python314.withPackages (
      ps: with ps; [
        numpy
        toolz
      ]
    ))
  ];
}
```
