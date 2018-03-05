# git-cheat-sheet

Simple Git commands Cheat Sheet

## Initialize a git folder

```bash
git init
```

## User config

```bash
git config user.name "Stéphane Francel"
git config user.email contact@avine.io
```

## Status and Log

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

# delete a branch merged or not
git branch --delete --force feature-one
```

## Staging and Unstaging

**For new untracked file:**

```bash
# creating new untracked file...
touch foo.txt

# add file to the index (tracking and staging)
git add foo.txt

# untrack file (use `git reset` without argument to reset all changes)
git reset -- foo.txt
```

**For already committed file:**

```bash
# modify file
echo "Foo..." >> foo.txt

# Staging the modification
git add foo.txt

# Unstage the file but keep the modification
git reset -- foo.txt

# Revert modification (ONLY for unstaged file)
git checkout -- foo.txt
```

## Revert all changes (staged on not)

```bash
# modify multiple files
echo "Foo..." >> foo.txt
echo "Bar..." >> bar.txt

# Staging one of them
git add foo.txt

# Restore the working tree to HEAD
git reset -- --hard
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
# delete file (modified or not, staged or not) from the index but intact keep it in the working tree
# (the file will be marked as untracked)
git rm --cached foo.txt
```

## Commit changes and amend last commit before push

```bash
# modify file
echo "Hello" >> foo.txt

# staging file
git add foo.txt

# commit changes with message
git commit --message "Hello World!"

# Oups! We forgot something!
echo "World!" >> foo.txt

# staging file
git add foo.txt

# commit changes without modifying the message
git commit --amend --no-edit

# push modified commit to the remote server
git push
```

## Amend last commit after push

Do this ONLY if you DON'T work with a team!

```bash
# Push some previous commit to the remote server
git push

echo "More Foo..." >> foo.txt
git add foo.txt
git commit --amend --no-edit

# Overwrite the history on the remote server
git push --force
```

## Amend last commit author

```bash
git commit --amend --author "John Doe <johndoe@avine.io>"
```

## Merging and rebasing branches

Create 2 new branches from master.

```bash
git branch feature-one master
git branch feature-two master
```

Work on the `feature-one`.

```bash
git checkout feature-one

# create a new file
touch fruits.txt

# modify, add and commit
echo "Orange" > fruits.txt
git commit -am "Add orange"

# modify, add and commit again
echo "Banana" >> fruits.txt
git commit -am "Add banana"

# rebase from master before merge (at this point this is useless...)
# go back to master
# merge feature-one into master (with no fast-forward)
git rebase master
git checkout master
git merge feature-one --no-ff -m "Merge feature-one"
```

Work the same way on the `feature-two`.

```bash
git checkout feature-two

touch technos.txt

echo "NodeJs" > technos.txt
git commit -am "Add NodeJs"

echo "Java" >> technos.txt
git commit -am "Add Java"

# but this time, rebasing from master before merging will do the trick!
git rebase master
git checkout master
git merge feature-two --no-ff -m "Merge feature-two"
```

Note: without rebasing from master before merging, the log history will not have been so clean!

```bash
git log --oneline --graph --decorate
```

Another benefit of using branches and always merging with no fast-forward allows us to view each feature as a single merge commit.

```bash
git log --oneline --graph --decorate --merges
```

Note: another strategy you an choose is to always rebase and do fast-forward merges in order to have a single line of history.

## Working remotely

**Push local repository to remote repository:**

```bash
# create and navigate to new local repository
mkdir myrepo
cd myrepo

# init a local repository with a branch called "master"
git init

# create and commit file
touch README.md
git commit -am "First commit"

# set url of a remote repository called "origin"
git remote add origin https://github.com/myuser/myrepo.git

# verify added remote
git remote --verbose

# push local branch master to remote origin
git push --set-upstream origin master
```

**Clone remote repository locally:**

```bash
# clone remote repository
git clone https://github.com/myuser/myrepo.git

# navigate to local repository
cd myrepo
```



---
WORK IN PROGRESS...

## Fetching from remote server

Assuming that new commits are available from remote server.
Thoses commits have been done by another developer.
And we also have finished our feature and we are ready to merge them into the master.

```bash
# back to master branch
git checkout master

# fetch changes from origin
git fetch origin

# apply changes using rebase strategy (not merge)
git rebase origin master

# or fetch and rebase at once!
git pull --rebase origin master
```

Now that you local repository is up-to-date, you can merge your feature branches on master as we did in the previous section.




TODO: diff entre 2 commits...
TODO: parler de "git push --set-upstream origin feat-1"
