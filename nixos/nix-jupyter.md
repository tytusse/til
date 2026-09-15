I had problems installing Jupyter via pip, because it was building C++ libs and failing due to nixos special way of handling linking to dynamic libs (*.so).
I attempted different tricks, installed gcc gloibally (was missing, unclear if this is "nix way").

~~I ended up using standard nixos package for Jupyter, which has its own python with appropriate dependencies and it works.~~

~~https://search.nixos.org/packages?channel=26.05&query=jupyter#show=jupyter~~

After more digging, I was able to marry with my "main python"

Used this guide: https://www.reddit.com/r/NixOS/comments/1aq58xv/comment/kqcuk0j/

And added `matplotlib` as well.

```nix
  users.users."tomek" = {
    # skipped some configs
    packages = with pkgs; [
      # .... skipped packages ....
      # python3
      (python314.withPackages (ps: with ps; [
        pip
        numpy # these two are
        scipy # probably redundant to pandas
        jupyterlab 
        pandas
        statsmodels
        scikit-learn
        matplotlib # <- added this
      ]))
      # jupyter - can do it like this, but matplotlib wont work
    ];
  };
```

Then
```bash
jupyter lab
```

And it works with plot (here example with plotting complex nums)

```python
import matplotlib.pyplot as plt

# Define complex numbers
vectors = [3 + 2j, -2 + 4j, -1 - 3j]

plt.figure(figsize=(6, 6))

# Plot each complex number as an arrow starting at (0,0)
for z in vectors:
    plt.quiver(0, 0, z.real, z.imag, angles='xy', scale_units='xy', scale=1, 
               color='blue', alpha=0.8)
    # Add a text label near the arrowhead
    plt.text(z.real * 1.1, z.imag * 1.1, f"{z}", fontsize=11, weight='bold')

# Structure the graph coordinates
plt.axhline(0, color='black', linewidth=1.2)
plt.axvline(0, color='black', linewidth=1.2)
plt.grid(True, which='both', linestyle=':', alpha=0.5)

plt.xlabel('Real')
plt.ylabel('Imaginary')
plt.title('Complex Vector Representation')
plt.xlim(-5, 5)
plt.ylim(-5, 5)

plt.show()
```
