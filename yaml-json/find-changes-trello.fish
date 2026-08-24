#!/usr/bin/env fish
# ldl camel 6718bee40c4a4abcc280d9bc 
# K8S IFACE 67d1affa4ad220f1a07e7fcc
yq '[ .actions.[] 
      | select(
        .type == "updateCard" 
        and .data.card.id == "6718bee40c4a4abcc280d9bc" 
        # and .data.old | has("desc")
        ) 
      | .data.date = .date
      | .data
      | pick(["old", "card", "date"])
      | select(.card | has("desc"))
    ]' trello-board.json 
