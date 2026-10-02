Example pipe with few concepts (need verification!)

```yaml
# this will be avaliabe in UI for manual run
parameters:
- name: branch_for_second_repo
  type: string
  default: 'main' # I will guerss that if we dont provide it, automatic run will fail or AZ will fail saving it (???).

  values: # allowed values
  - main
  - tests

variables:
  branch_in_foobar: ${{ parameters.branch_for_second_repo }}

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
# in default branch
- checkout: repo-foobar-alias
  path: "second"
# override default
- checkout: repo-foobar-alias
  path: "third"
  branch: barbaz
- bash: |
    echo "Current Foobar repo branch variable: $(variables.branch_in_foobar)"
    cat $(Build.SourcesDirectory)/second/a-file.txt
  displayName: 'some description'
```
