Example pipe with few concepts

```yaml
variables:
  branch_in_foobar: 'baz'

# trigger: none - to disable auto-trigger
trigger: 
  branches:
    include:
      # default behavior ("all branches") needs to be repeated if we use explicit triggers
      # https://learn.microsoft.com/en-us/azure/devops/pipelines/yaml-schema/trigger?view=azure-pipelines#examples-2
      - '*'
    exclude:
      - "wip/*"
  paths:
    exclude:
      - "docs"
      - "src/**/side-notes"

resources:
  repositories:
  - repository: repo-foobar-alias
    name: Foobar
    ref: ${{ variables.branch_in_foobar }}
    type: git

pool:
  vmImage: ubuntu-latest

steps:
- checkout: self
- checkout: repo-foobar-alias
  branch: ${{ variables.branch_in_foobar }}
  path: "second"
- bash: |
    echo "Current Foobar repo branch variable: $(variables.branch_in_foobar)"
    cat $(Build.SourcesDirectory)/second/a-file.txt
  displayName: 'some description'
```
