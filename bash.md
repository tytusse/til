# nice cheat-sheet
https://devhints.io/bash

# xtrace, pipefail and other good defaults
```bash
set -x
set -eou pipefail
```

# current script dir spell
```bash
SCRIPT_DIR=$(realpath $(dirname $0))
```

# hashbang with env
```bash
#!/usr/bin/env bash
```
