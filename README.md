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

# create new branch
git branch [NAME]

# checkout existing branch
git checkout [NAME]

# or create and checkout new branch at once!
git checkout -b [NAME]

# delete a fully merged branch
git branch --delete [NAME]

# delete a branch merged or not
git branch --delete --force [NAME]
```

## Staging and Unstaging

- For new file

```bash
# creating new untracked file...
touch [FILE]

# add file to the index (tracking and staging)
git add [FILE]

# untrack file (use `git reset` without argument to reset all changes)
git reset -- [FILE]
```

- For existing file

```bash
# modify file
echo "some content..." >> [FILE]

# Staging the modification
git add [FILE]

# Unstage the file but keep the modification
git reset -- [FILE]

# Revert modification (ONLY for unstaged file)
git checkout -- [FILE]
```

## Revert all changes (staged on not)

```bash
# modify multiple files
echo "some content..." >> [FILE1]
echo "some content..." >> [FILE2]

# Staging one of them
git add [FILE1]

# Restore the working tree to HEAD
git reset -- --hard
```

## Delete file from the index and the working tree

```bash
# delete unmodified file from the index and the working tree
git rm [FILE1]

# modify file
echo "some content..." >> [FILE2]

# delete modified file (staged or not) from the index and the working tree
git rm --force [FILE1]
```

## Delete file from the index but keep it in the working tree

```bash
# delete file (modified or not, staged or not) from the index but intact keep it in the working tree
# (the file will be marked as untracked)
git rm --cached [FILE]
```

## Commit changes and amend last commit before push

```bash
# modify file
echo "Hello" >> [FILE]

# staging file
git add [FILE]

# commit changes with message
git commit --message "Hello World!"

# Oups! We forgot something!
echo "World!" >> [FILE]

# staging file
git add [FILE]

# commit changes with message
git commit --amend --no-edit

# push modified commit to the remote server
git push
```

## Amend last commit after push

Do this ONLY if you DON'T work with a team!

```bash
# Push some previous commit to the remote server
git push

echo "more..." >> [FILE]
git add [FILE]
git commit --amend --no-edit

# Overwrite the history on the remote server
git push --force
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

# modify, stage and commit
echo "Orange" > fruits.txt
git add fruits.txt
git commit -m "Add orange"

# modify, stage and do another commit
echo "Banana" >> fruits.txt
git add fruits.txt
git commit -m "Add banana"

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
git add technos.txt
git commit -m "Add NodeJs"

echo "Java" >> technos.txt
git add technos.txt
git commit -m "Add Java"

# but this time, rebasing from master before merge will do the trick!
git rebase master
git checkout master
git merge feature-two --no-ff -m "Merge feature-two"
```

Note: without rebasing from master before merging, the log history will not have been so clear!

Now, verify that the log history of the master branch is clean! we did it!

```bash
git log --oneline --graph --decorate
```

## Fetching from remote

```bash
# back to master branch
git checkout master

# fetch changes from remote server
git fetch

# apply changes using rebase strategy (not merge)
git rebase

# or fetch and rebase at once!
git pull --rebase
```

Now that you local repository is up-to-date, you can merge your feature branches on master as we did in the previous section.
