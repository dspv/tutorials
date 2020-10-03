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

### Some SSH Magic ###
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

