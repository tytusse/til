# Tags vs remotes
In git, there is no link (in `.git/refs/` dir or `.git/packed-refs` file) that
would tell whether local tag is related to a remote tag.
The only info about that is to explicitly compare remote tags with local ones.
So if local tag has *no* remote tag equivalent, one cannot tell if this is 
because remote tag existed but was deleted **or** tag being purely local one.

In contrast, this is different than branches, where local `refs` DB has 
explicit info about remote refs (its unclear to me how "tracking" branches
work exactly though, research needed).

In order to make git always prune tags (note: `jj` seems to ignore this...)
`git config fetch.pruneTags true`

In order to prune tags explicitly
`git fetch --prune --prune-tags`
