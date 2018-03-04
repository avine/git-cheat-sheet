# git-cheat-sheet

Simple Git commands Cheat Sheet

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
git branch -a

# create new branch
git branch [NAME]

# checkout existing branch
git checkout [NAME]

# create and checkout new branch
git checkout -b [NAME]
```

## Staging and Unstaging

- For new file

```bash
# creating new untracked file...
touch [FILE]

# add file to the index (tracking and staging)
git add [FILE]

# untrack file (use `git reset` without argument to reset all changes)
git reset [FILE]
```

- For existing file

```bash
# modify file
echo "some content..." >> [FILE]

# Staging the modification
git add [FILE]

# Unstage the file but keep the modification
git reset [FILE]

# Revert modification (ONLY for unstaged file)
git checkout -- [FILE]
```

## Revert all changes (stagged on not)

```bash
# modify multiple files
echo "some content..." >> [FILE1]
echo "some content..." >> [FILE2]

# Staging one of them
git add [FILE1]

# Restore the working tree to HEAD
git reset --hard
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
# delete file (modified or not, staged or not) from the index but keep it in the working tree (with its modification)
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
