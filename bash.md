# nice cheat-sheet
https://devhints.io/bash

# template script
- uses `env` hashbang
- sets xtrace
- puts script dir into var

```bash
#!/usr/bin/env bash

set -x
set -eou pipefail

SCRIPT_DIR=$(realpath $(dirname $0))
```
