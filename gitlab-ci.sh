##############################
### GitLab runner on MacOS ###
##############################

## Install and use GitaLab Runner

## Install GitLab Runner
## Register it
## Start the Runner

## I installed it with recommended way
## Registered it
## And now ready to start

## Configure GitLab CI/CD
## Add .gitlab-ci.yml to the project's root folder 
## .gitlab-ci.yml

demo-job-1:
    tags:
        - avocado: #tags memtioned when runner registered
    script:
        - echo 'Hello World! YupYup!'

## Looks like everyhing is ready
## And the only thing left is to make a change in our code



#########################
### Some YML examples ###
#########################

stages:
  - test
  - build
  - deploy

test:
  stage: test
  script: echo "Running tests"

build:
  stage: build
  script: echo "Building the app"

deploy_staging:
  stage: deploy
  script:
    - echo "Deploy to staging server"
  environment:
    name: staging
    url: https://staging.example.com
  only:
    - master
