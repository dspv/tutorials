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



######################
### Some SSH Magic ###
######################

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



################
### Branches ###
################
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



#############
### Merge ###
#############
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



###########################
### Branching & Merging ###
###########################

# Create a new branch
git branch [branch name]
git branch dev
# switch to a new branch
git checkout [branch name]
git checkout dev
# see the branches
git branch

# merge the new branch with master branch
git merge [new branch name]
git merge

# delete the branch (locally)
git branch -d [branch name]
git branch -d dev
git push origin --delete [branch name]
git push origin --delete dev



######################
### And once again ###
######################
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



#####################################################################################
#####################################################################################
#####################################################################################



######################################
### Some practises and repetitions ###
######################################

### And once again
# Let's create a new repo
mkdir myf
cd myf
git init
git status
git add . # or a filename
git commit -m "why we do this commit"

# then create a repo on GitHub
# and connect it to the existing repo locally
# let's call it 'repo1'
git remote add origin https://github.com/dspv/repo1.git
git push -u origin master

### Some helpful things
# autocomplete
# put git-completion.bash script to the home dir
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
# add this to .bash-profile
vi ~/.bash_profile

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# set up colors
git config color.ui



#####################################################################################
#####################################################################################
#####################################################################################



#######################
### Tags & Releases ###
#######################

## We use tags to make some release points and be able to roll back
## let's say we need to change to a master branch
git checkout master

# create a tag
git tag [name]
git tag v1.0
# check if the tag has been created
git tag 
# some annotation
git tag v1.1 -m "v1.1 release"

## How to display tags?
git tag
git show v1.0
git tag -l 'v1.*'

## But we don't see these newly created tags on GitHub
## To make it works we need to:
# push v1.0 tag to the repo
git push origin v1.0

# push all the tags to the repo
git push --tags

# delete tags (locally)
git tag -d v1.0
git tag --delete v1.0

# delete tags (from remote)
git push origin -d v1.0
git push prigin --develte v.1.0
git push origin :v1.0

## When we create a software we can tag some stable versions with TAGS
## We cannot checkout tags in Git but
## We can create a branch from a tag and checkout the branch
git checkout -v [branch name] [tag name]
git checkout -v ReleaseVer1 v1.0

## We can create a tag from a past commit
git tag [tag name] [ref commit]
git tag v1.2 5fcdb03



#####################################################################################
#####################################################################################
#####################################################################################



##############################
### Git Merge & Git Rebase ###
##############################

## Let's say we created a new repo: REP1
## We have only 'master' branch
## Created a file m1.txt on the master branch
## Created then a new 'feature' branch 
## Added a file f1.txt to the 'feature' branch
## Get back to 'mater' branch and made a file m2.txt
## WHAT TO DO???

## Two ways to integrate changes from one branch to another
## - Merge
## - Rebase



