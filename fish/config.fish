abbr --add ga git add

abbr --add gm git merge --ff-only

abbr --add gcm git commit -m

abbr --add gc git checkout
abbr --add gcb git checkout -b

abbr --add gb git branch
abbr --add gba git branch --all -vv
abbr --add gbd git branch --delete
abbr --add gbD git branch --delete --force
abbr --add gbs git branch --set-upstream-to
abbr --add gbm git branch --move

abbr --add gd git diff
abbr --add gdn git diff --name-only

abbr --add gf git fetch
abbr --add gfa git fetch --all

abbr --add gl git log --graph --decorate
abbr --add glo git log --graph --decorate --oneline
abbr --add gla git log --all --graph --decorate
abbr --add glao git log --all --graph --decorate --oneline

abbr --add gr git rebase
abbr --add gri git rebase --interactive
abbr --add gra git rebase --abort
abbr --add grc git rebase --continue

abbr --add grh git reset --hard

abbr --add gs git status

set fish_term24bit 1

if command -v tmux; and test -z $TMUX
  exec tmux new-session -A -s mysession
end
