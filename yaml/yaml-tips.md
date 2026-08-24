Tool to query yaml: https://mikefarah.gitbook.io/yq
On arch: `yay go-yq`

Example usage: https://mikefarah.gitbook.io/yq/recipes

# Selecting all storage class names referenced by PVCs in k8s YAML file
```bash
yq 'select(.kind == "PersistentVolumeClaim") | .metadata.name + ":" + .spec.storageClassName' kubernetes-special/ACC/template.yaml
```

# selecting all description changes in trello JSON export related to certain card

```bash
yq '[ 
    .actions.[] 
    | select(.type == "updateCard" and .data.card.id == "67d1affa4ad220f1a07e7fcc") 
    | {data: .data }
    ]' 
    trello-board.json
```
