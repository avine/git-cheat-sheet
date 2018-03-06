# git-cheat-sheet

Simple GIT commands that produce a clean log history

## Initialize repository

*Create local repo:*

```bash
# create new folder and navigate into it
mkdir myrepo
cd myrepo

# init local repo with branch called "master"
git init

# create and commit file
touch README.md
git add README.md
git commit --message "First commit"

# set url of remote repo called "origin"
git remote add origin https://github.com/myuser/myrepo.git

# verify added remote
git remote --verbose

# push local branch "master" to remote repo "origin"
git push --set-upstream origin master
```

*Or clone existing remote repo locally:*

```bash
# clone remote repo
git clone https://github.com/myuser/myrepo.git

# navigate to local repo
cd myrepo
```

## User config

Configure user name and email before commiting.

```bash
git config user.name "Stéphane Francel"
git config user.email contact@avine.io
```

## Status and log

```bash
git status
git log --oneline --graph --decorate
```

## Branches

```bash
# list all branches
git branch --all

# create new branch of master
git branch feature-one master

# checkout existing branch
git checkout feature-one

# or create and checkout new branch at once!
git checkout -b feature-one master

# delete a fully merged branch
git branch --delete feature-one

# delete a branch whether merged or not
git branch --delete --force feature-one
```

## Staging and unstaging

*For new untracked file:*

```bash
# creating new untracked file...
touch foo.txt

# add file to the index (tracking and staging)
git add foo.txt

# untrack file (use `git reset` without argument to reset all changes)
git reset -- foo.txt
```

*For already committed file:*

```bash
# modify file previously committed
echo "More Foo..." >> foo.txt

# staging the modification
git add foo.txt

# unstage the file but keep the modification
git reset -- foo.txt

# revert modification (ONLY for unstaged file)
git checkout -- foo.txt
```

## Revert all changes (staged on not)

```bash
# modify multiple files
echo "Foo..." >> foo.txt
echo "Bar..." >> bar.txt

# staging one of them
git add foo.txt

# restore the working tree to HEAD
git reset --hard
```

## Delete file from the index and the working tree

```bash
# delete unmodified file from the index and the working tree
git rm foo.txt

# modify file
echo "More Bar..." >> bar.txt

# delete modified file (staged or not) from the index and the working tree
git rm --force bar.txt
```

## Delete file from the index but keep it in the working tree

```bash
# delete file (modified or not, staged or not) from the index but keep it in the working tree
git rm --cached foo.txt
```

After that, the file will be marked as untracked.

## Commit changes and amend last commit before push

```bash
# modify file
echo "Hello" >> foo.txt

# staging file
git add foo.txt

# commit changes with message
git commit --message "Hello World!"

# oups! we forgot something!
echo "World!" >> foo.txt

# staging file
git add foo.txt

# amend the last commit (without modifying the message)
git commit --amend --no-edit

# push modified commit to the remote server safely
git push
```

## Amend last commit after push

```bash
# push some previous commit to the remote server
git push

# oups! we forgot something!
touch baz.txt
echo "Baz..." > baz.txt
git add baz.txt

# adding baz.txt to the last commit
git commit --amend --no-edit

# overwrite the history on the remote server
git push --force
```

Do this ONLY if you DON'T work with a team!

## Amend last commit author

```bash
git commit --amend --author "John Doe <johndoe@avine.io>"
```

## Rebasing and merging

### Using "no fast forward" strategy

Assuming someone works on `feature-one`.

```bash
# clone repo and checkout new branch
git clone https://github.com/myuser/myrepo.git
git checkout -b feature-one

# create new file
touch fruits.txt

# modify, add and commit
echo "Orange" > fruits.txt
git add fruits.txt
git commit -m "Add Orange"

# modify, add and commit again (option -am works for already tracked file)
echo "Banana" >> fruits.txt
git commit -am "Add Banana"
```

*Log history of branch `feature-one`:*

```txt
$ git log --oneline --graph --decorate
* 484dbf6 (HEAD -> feature-one) Add Banana
* c7fc421 Add Orange
* 0285f89 (origin/master, origin/HEAD, master) Initial commit
```

Meanwhile, someone else was working on `feature-two`...

```bash
git clone https://github.com/myuser/myrepo.git
git checkout -b feature-two

touch technos.txt

echo "NodeJs" > technos.txt
git add technos.txt
git commit -m "Add NodeJs"

echo "Java" >> technos.txt
git commit -am "Add Java"
```

*Log history of branch `feature-two`:*

```txt
$ git log --oneline --graph --decorate
* 64364db (HEAD -> feature-two) Add Java
* 120e8c2 Add NodeJs
* 0285f89 (origin/master, origin/HEAD, master) Initial commit
```

Next, the first developer is pushing his work.

```bash
# leave branch feature-one and go back to branch master
git checkout master

# merge feature-one into master (with no-fast-forward)
git merge feature-one --no-ff -m "Merge feature-one"

# push commits to remote origin
git push origin
```

*Log history of branch `master`:*

```txt
*   0f6ca39 (HEAD -> master, origin/master, origin/HEAD) Merge feature-one
|\
| * 484dbf6 (feature-one) Add Banana
| * c7fc421 Add Orange
|/
* 0285f89 Initial commit
```

Now, how can the other developer (who worked on `feature-two`) also push his work ?

```bash
# while staying on the branch feature-two, get branch master
# up-to-date and merged into the current branch
git pull --rebase origin master:master

# the previous command is equivalent to:
#   git checkout master
#   git pull --rebase origin
#   git checkout feature-two
#   git rebase master

# back to branch master, merge feature-two into master (with no-fast-forward)
git checkout master
git merge feature-two --no-ff -m "Merge feature-two"

# push commits to remote origin
git push origin
```

*Log history of branch `master`:*

```txt
$ git log --oneline --graph --decorate
*   8e5a570 (HEAD -> master, origin/master, origin/HEAD) Merge feature-two
|\
| * 0aa4f57 (feature-two) Add Java
| * 1ad2fe8 Add NodeJs
|/
*   0f6ca39 Merge feature-one
|\
| * 484dbf6 Add Banana
| * c7fc421 Add Orange
|/
* 0285f89 Initial commit
```

So, always merging branches with no-fast-forward option, ensures that each feature has a merge commit.

This is usefull because we can quickly get a summary of what has been developed so far on branch master using `git log --merges`.
This way, we skip the intermediate commits and focus on the list of features.

```txt
$ git log --oneline --graph --decorate --merges
* 8e5a570 (HEAD -> master, origin/master, origin/HEAD) Merge feature-two
* 0f6ca39 Merge feature-one
```

Without rebasing from master before merging, the log history will not have been so clean!

*Log history without rebasing:*

```text
$  git log --oneline --graph --decorate
*   518d342 (HEAD -> master, origin/master, origin/HEAD) Merge feature-two
|\
| * 36b9e38 (feature-two) Add Java
| * 6acf6ba Add NodeJs
* |   cdc7ce7 Merge feature-one
|\ \
| |/
|/|
| * fa1df45 Add Banana
| * 6de9efd Add Orange
|/
* 0285f89 Initial commit
```

### Using "fast forward" strategy

Another strategy you an choose is to always use `git merge --ff-only` instead of `git merge --no-ff`

If you redo from the begining the commands of the previous section using this strategy then you'll get a single line of history on the branch master.

```txt
$ git log --oneline --graph --decorate
* eee05a6 (HEAD -> master, origin/master, origin/HEAD, feature-two) Add Java
* 4801abf Add NodeJs
* 8ec6840 Add Banana
* cc3fdad Add Orange
* 0285f89 Initial commit
```

<!-- TODO: talk about "git diff" between any 2 commits... -->
