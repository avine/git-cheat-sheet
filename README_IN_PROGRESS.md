# GIT

## Concepts

Git is distributed, meaning every one who has the repository, has the full history of the project.

Naming:

- The Working directory is also named Working tree.
- The Staging area is also named Index.
- The Repository

Each commit contains a complete snapshot of the project.

When git says `"nothing to commit, working tree clean"`, it means the Working directory, the Staging area and the Repository are in the same state.

It might seems strange, but it means that even the Staging area contains the complete snapshot of the project at this point. You can verify this, by running the command `git ls-files --cached`, which output the list of files that are in the staging area.

## Getting help

```bash
# Full documentation
git <COMMAND> --help

# Documentation summary
git <COMMAND> -h
```

Example: `git config --help`.

## Config

You can configure Git at 3 levels:

- `--system`: for all users on the system
- `--global`: for all repositories of the user
- `--local`: for the current repository

### User's name and email

```bash
git config --global user.name "<FULLNAME>"
git config --global user.email <EMAIL>
```

Example: `git config --global user.name "Stéphane Francel"`.

Usage example: user infos defines the commit author section.

### EOL

#### On Windows operating system

Uses: `\r\n` (carriage return + line feed)

We need to tell Git to:

- always add `crlf` when fetching from the Repository
- always remove `crlf` when pushing to the Repository

```bash
git config --system core.autocrlf true
```

#### On Mac or Linux operating system

Uses: `\n` (line feed)

We need to tell Git to:

- fetch code as it from the Repository (because internally Git uses line feed as well)
- remove `crlf` on push to Repository (if accidentally present)

```bash
git config --system core.autocrlf input
```

### Code editor (VSCode)

```bash
git config --global core.editor "code --wait"
```

Usage example: the code editor can be opened to fill the commit message.

### Diff tool

Git offers a range of difftools pre-configured "out-of-the-box" (kdiff3, kompare, tkdiff, meld, xxdiff, emerge, vimdiff, gvimdiff, ecmerge, diffuse, opendiff, p4merge and araxis), and also allows you to specify your own.

#### Using pre-configured `vimdiff`

For example, let's configure Git to use `vimdiff`:

```bash
git config --global diff.tool vimdiff
```

And th  at's it!
Git knows how to launch the tool named `vimdiff`.
Just run the following command to open the diff tool:

```bash
git difftool
```

### Using VSCode as difftool

```bash
# Let's choose "vscode" as name for our diff tool
git config --global diff.tool vscode

# Tell Git what command to execute in order to run the diff tool
git config --global difftool.vscode.cmd "code --wait --diff \$LOCAL \$REMOTE"
```

Now, if you look at the `.gitconfig` file (by running `git --config --edit`), you'll find the following lines:

```txt
[diff]
  tool = vscode
[difftool "vscode"]
  cmd = code --wait --diff $LOCAL $REMOTE
```

### Listing the Git config

```bash
git config --global --list
```

### Editing the Git config

```bash
git config --global --edit
```

### Ignoring files

Use the `.gitignore` file to list the files you want to ignore.

> Notice that adding a file that is already tracked will not make it ignored.
> In this case, you have to remove it manually.

### Cleaning untracked files

```bash
git clean -d --force
# or
git clean -d --interactive
```

`-d` option allows to also clean directories.

Notice that is will not touch the files listed in `.gitignore`.

### Adding files to the staging area

```bash
git add <FILES>
```

If the file was untracked, it becomes tracked.
If the file was modified in the working directory, it becomes staged.
If the file was deleted in the working directory, it becomes deleted in the staging area.

### Removing files from both the working directory and the staging area

```bash
git rm <FILES>

# Which is equivalent to:
rm <FILES> && git add <FILES>
```

### Removing files only from the staging area

```bash
git rm --cached <FILES>
```

> The removed files becomes `untracked`.

### Moving files

```bash
git mv <SOURCE> <DESTINATION>

# Which is equivalent to:
mv <SOURCE> <DESTINATION> && git add <SOURCE> <DESTINATION>
```

### Restoring files in the working directory from the staging area

Copy the content of the staging area to the working directory.

```bash
git restore <FILES>
git restore --worktree <FILES> # equivalent
```

### Restoring files in the staging area from the last commit (HEAD)

Copy the content of the last commit to the staging area.

```bash
git restore --staged <FILES>
```

### Listing files

#### Listing all files in the staging area

Returns the list of all tracked files.

```bash
git ls-files
git ls-files --cached # equivalent
```

#### Listing all untracked files in the working directory

```bash
git ls-files --others --exclude-standard
```

### Diffing between the working directory and the staging area

```bash
git diff
```

### Diffing between the staging area and the last commit (HEAD)

```bash
git diff --staged
```

### Listing files in the diff

The `diff` command returns a lot of informations.
If you are only interested in the list of files related in the `diff`, run:

```bash
# Listing files in the staging area that have been modified in the working directory
git diff --name-only
git ls-files --modified # equivalent

# Listing files in the last commit that have been modified in the staging area
git diff --staged --name-only
```

### Status

```bash
git status
git status --short
```

> TODO: talk about the --short option....
> Which combines: git diff --name-only && git diff --name-only (and more: untracked files)

### Commiting staged files to the repository

```bash
git commit --message "<MESSAGE>"

git commit # Will open the default editor to fill the commit message
```

### Staging and commiting "all" modified files at once

```bash
git commit --all --message "<MESSAGE>"
```






### Restoring files from a previous commit

```bash
git restore --source=<COMMIT> <FILES>
```
