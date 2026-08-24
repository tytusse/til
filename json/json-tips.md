Tool to query yaml/json: https://mikefarah.gitbook.io/yq
On arch: `yay go-yq`

NOTE: there is a more mature JSON tool: `jq`, however `yq` sees enough for now.

See 
- [some scripts](../yq/)
- [YAML tips](../yaml/yaml-tips.md)

Example usage: https://mikefarah.gitbook.io/yq/recipes

- YQ is actually an **imperative** language - it "changes" the input with `=` and `|=` operators
- YQ can be "select this and that" but it will still be via imperative `=` mixed with `pick[]` and element select
- YQ "select" is like SQL "where"
- SQL "Select" in YQ is raw "dot" notation, i.e. `{"name":"apple", "color":"red"}` -> `.name` -> `"apple"`

# selecting all description changes in trello JSON export related to certain card

```bash
yq '[ .actions.[] 
      | select(
        .type == "updateCard" 
        and 
        .data.card.id == "6718bee40c4a4abcc280d9bc" 
        ) 
      | .data.date = .date
      | .data
      | pick(["old", "card", "date"])
      | select(.card | has("desc"))
    ]' trello-board.json 
```

Breakdown:
- at the beginning, `.` refers to ROOT of the file
- `[...]` makes the result an array; without this, it will spit JSON objects with newline separators only.
- `.actions` - Trello JSON has such property, which is an array of all history in board;
  Afer this, `.` is no longer ROOT, it is `actions` property (array)
- `.[]` creates an iteration over each array item; 
  Otherwise we would need to explicitly index it, i.e., `.actions[0]`, `actions[42]`, etc.
  After this, `.` is an **element** of `actions` (array **item**);
- after `|` we are working on separate **item** of `.actions[]` array;
- `| select(...)` filters actions by trello CARD ID and leaves only card updates;
  we are not interested in things like comments here (see trello JSON to see the schema)
- `| .data.date = .date` we copy actions item "date" to its  "data" property (we **modify** "data")
- `| .data` we make `.` to be `data` nfor the next statements
- `| pick()` we are only interested in specifc properties of "data", most importantly - "old"
- `| select(.card | has("desc"))` finally, we filter actions to those that changed description
  In Trallo JSON, if `action[].data.card` has `desc`, then the action included "change of description"
