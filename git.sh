### Cheat Sheet ###
https://training.github.com/downloads/github-git-cheat-sheet/

# init a new repo
git init

# check status: what to track, etc
git status

# add files to track
git add index.html
# add everything in this folder
git add .

# commit changes
git commit -m "Initial commit" -m "Some description"

# history of commits
git log


# ------------------ #
### Some SSH Magic ###
# ------------------ #
# generate a new SSH key (email to account)
# then use *.pub file to add a new SSH key to GitHub account
ssh-keygen -t rsa -b 4096 -C "dmitriy@solodukha.com"
pbcopy < [file] # to copy to clipboard

# when create a new repo
# we need to create a repo first on GitHub
# then
git init # in the new repo on local machine

# add a place where to push
git remote add origin https://github.com/dspv/demo-repo-2.git 

# take a look at all the remote hosts
git remote -v

# doc
https://training.github.com/downloads/github-git-cheat-sheet/


# ------------ #
### Branches ###
# ------------ #
# check all the branches
git branch

# create a new branch
git checkout -b feature
git checkout -b feature-111 # issue number
git checkout -b feature-readme-instructions

# then deploy
git status
git add .
git commit -m "comment" -m 'description'

## Merging branches
# take a look on cnahges
git diff [branch name]
git diff feature-readme-001

# --------- #
### Merge ###
# --------- #
git merge feature-readme-001

# But #
# But #
# there's another way
git checkout feature-readme-001
git status
git push -u origin feature-readme-001

# then
# we can delete branch
git branch -d feature-readme-001
# and check the branchs
git branch

# ------------------ #
### And once again ###
# ------------------ #
git status
git diff
# (git add .)
# add and commit and the same time 
# (only works for modified files)
git commit -am "comment"
git checkout master

git merge master

# unstage changes
git reset
# one update back
git reset HEAD~1
# get back to a specific point (time machine!)
git reset [commit hash]

### Chet Sheet ###
https://training.github.com/downloads/github-git-cheat-sheet/
