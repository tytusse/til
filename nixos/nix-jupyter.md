I had problems installing Jupyter via pip, because it was building C++ libs and failing due to nixos special way of handling linking to dynamic libs (*.so).
I attempted different tricks, installed gcc gloibally (was missing, unclear if this is "nix way").

I ended up using standard nixos package for Jupyter, which has its own python with appropriate dependencies and it works.

https://search.nixos.org/packages?channel=26.05&query=jupyter#show=jupyter
